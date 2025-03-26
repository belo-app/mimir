locals {
  svc_domain     = "belo.services"
  task_cpu       = var.required_cpu
  otel_agent_tag = var.environment != "prod" ? "latest-stg" : "latest"
}

data "aws_region" "current" {}

// ------------ IAM ------------ //

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
}

resource "aws_iam_role" "task_role" {
  name = "${var.name}_task_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  dynamic "inline_policy" {
    for_each = var.task_inline_policy != null ? [var.task_inline_policy] : []
    content {
      name   = "${var.name}_inline_policy"
      policy = var.task_inline_policy
    }
  }
}


// ------------ Cloudwatch ------------ //

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.container_logs_retantion_days
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}

// ------------- Secrets ------------- //

/*resource "aws_secretsmanager_secret" "superset_google_oauth_secret" {
  name        = "SUPERSET_AUTH_GOOGLE_CLIENT_SECRET"
  description = "Client secret for ${var.name}'s OAuth Client credentials"
}*/


// --------------- ECS --------------- //


module "ecs_task_sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=master"

  name        = "${var.name}-sg"
  description = "Security group for ${var.name} ECS task with ${var.container_port} port openned"
  vpc_id      = var.vpc_id

  egress_rules = ["all-all"]

  tags = {
    "Name" = "${var.name} ECS Task Security Group"
  }

}

module "ecs_container_definition" {
  source = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=main"

  container_name   = var.name
  container_image  = "${var.docker_registry}/${var.docker_image}:${var.docker_image_tag}"
  container_cpu    = var.required_cpu
  container_memory = var.required_memory
  log_configuration = {
    "logDriver" = "awslogs",
    "options" = {
      "awslogs-group" : "${aws_cloudwatch_log_group.log_group.name}",
      "awslogs-region" : "${data.aws_region.current.name}",
      "awslogs-stream-prefix" : "ecs"
    }
  }
  port_mappings = [
    {
      containerPort = "${var.container_port}"
      hostPort      = "${var.container_port}"
      protocol      = "tcp"
    }
  ]

  map_environment = merge(var.task_env_vars, { ENV = var.environment }, { PORT = var.container_port }, { AWS_REGION = "${data.aws_region.current.name}" })
  secrets         = var.task_secrets != null ? flatten([for k, v in var.task_secrets : { name = k, valueFrom = v }]) : []
}

module "ecs_container_definition_otelagent" {
  source = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=main"

  container_name   = "otel-agent"
  container_image  = "${var.docker_registry}/otel-agent:${local.otel_agent_tag}"
  container_cpu    = var.otel_required_cpu
  container_memory = var.otel_required_memory
  log_configuration = {
    "logDriver" = "awslogs",
    "options" = {
      "awslogs-group" : "${aws_cloudwatch_log_group.log_group.name}",
      "awslogs-region" : "${data.aws_region.current.name}",
      "awslogs-stream-prefix" : "otel-${var.name}"
    }
  }
  port_mappings = [
    {
      containerPort = "4318"
      hostPort      = "4318"
      protocol      = "tcp"
    }
  ]
}

module "alb_to_task_sg_rule" {
  count = var.create_alb_tg ? 1 : 0

  source                   = "../sg-rule"
  rule_type                = "ingress"
  port                     = var.container_port
  protocol                 = "tcp"
  security_group_id        = module.ecs_task_sg.security_group_id
  source_security_group_id = [var.alb_source_sg_id]
}

module "task_to_redis_lock_cache_sg_rule" {
  count = var.lock_cache_sg_id != var.db_cache_sg_id && var.db_cache_sg_id != null ? 1 : 0

  source                   = "../sg-rule"
  rule_type                = "ingress"
  port                     = 6379
  protocol                 = "tcp"
  security_group_id        = var.lock_cache_sg_id
  source_security_group_id = [module.ecs_task_sg.security_group_id]
}

module "task_to_redis_db_cache_sg_rule" {
  count = var.db_cache_sg_id != null ? 1 : 0

  source                   = "../sg-rule"
  rule_type                = "ingress"
  port                     = 6379
  protocol                 = "tcp"
  security_group_id        = var.db_cache_sg_id
  source_security_group_id = [module.ecs_task_sg.security_group_id]
}

resource "aws_ecs_task_definition" "task_def" {
  family                   = "${var.name}-task-def"
  requires_compatibilities = [var.container_launch_type]
  network_mode             = "awsvpc"
  cpu                      = var.otel_agent_enabled ? var.required_cpu + var.otel_required_cpu : var.required_cpu
  memory                   = var.otel_agent_enabled ? var.required_memory + var.otel_required_memory : var.required_memory
  container_definitions    = var.otel_agent_enabled ? "[${module.ecs_container_definition.json_map_encoded},${module.ecs_container_definition_otelagent.json_map_encoded}]" : module.ecs_container_definition.json_map_encoded_list
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  skip_destroy             = true

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}-service"
  cluster         = var.ecs_cluster_name
  task_definition = aws_ecs_task_definition.task_def.arn
  desired_count   = var.container_desired_count
  launch_type     = var.container_launch_type
  propagate_tags  = "TASK_DEFINITION" # Its the same
  network_configuration {
    subnets         = var.subnets
    security_groups = [module.ecs_task_sg.security_group_id]
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "host"
  }

  dynamic "load_balancer" {
    #for_each = aws_lb_target_group.lb_target_group[count.index] ? [aws_lb_target_group.lb_target_group[count.index].arn] : []
    for_each = aws_lb_target_group.lb_target_group
    content {
      target_group_arn = aws_lb_target_group.lb_target_group[0].arn
      container_name   = var.name
      container_port   = var.container_port
    }
  }

  depends_on = [aws_lb_target_group.lb_target_group]
}

# ALB Target group + rules

data "aws_lb" "alb" {
  count = var.create_alb_tg ? 1 : 0
  name  = var.alb_name
}

resource "aws_lb_target_group" "lb_target_group" {
  count       = var.create_alb_tg ? 1 : 0
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    protocol            = "HTTP"
    path                = var.health_check_path
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
    timeout             = "10"
    interval            = "15"
    matcher             = "200,301"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "random_integer" "priority" {
  count = var.create_alb_tg && var.name != "loki-core" ? 1 : 0
  min   = 1
  max   = 50000
  keepers = {
    listener_arn = var.alb_listener_arn
  }
}
resource "aws_lb_listener_rule" "redirect_to_tg" {
  count        = var.create_alb_tg ? 1 : 0
  listener_arn = var.alb_listener_arn
  priority     = var.name == "loki-core" ? 50000 : random_integer.priority[count.index].result # if core -> lowest rule priority

  condition {
    host_header {
      values = length(var.alb_host_pattern) == 0 ? ["api.${local.svc_domain}"] : [for _, v in var.alb_host_pattern : "${v}.${local.svc_domain}"]
    }
  }

  dynamic "condition" {
    for_each = length(var.alb_path_pattern) == 0 ? [] : var.alb_path_pattern
    content {
      path_pattern {
        values = var.alb_path_pattern
      }
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group[count.index].arn
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_rule" "redirect_to_tg_odin" {
  count        = var.create_alb_tg && var.name == "odin" ? 1 : 0
  listener_arn = var.alb_listener_arn
  priority     = random_integer.priority[count.index].result - 1 # if core -> lowest rule priority

  condition {
    host_header {
      values = length(var.alb_host_pattern) == 0 ? ["api.${local.svc_domain}"] : [for _, v in var.alb_host_pattern : "${v}.${local.svc_domain}"]
    }
  }

  condition {
    path_pattern {
      values = ["/dashboard/*", "/payment/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group[count.index].arn
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "alb_entry" {
  zone_id = var.dns_zone_id
  name    = var.alb_host_pattern[0]
  type    = "CNAME"
  ttl     = "300"
  records = [data.aws_lb.alb[0].dns_name]
}
