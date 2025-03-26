# ECS Task
module "ecs_task" {
  source = "./modules/ecs-task"

  # Network + ECS Cluster
  name             = var.project
  vpc_id           = local.vpc_id
  subnets          = local.prv_subnets
  environment      = var.environment
  ecs_cluster_name = local.ecs_cluster
  dns_zone_id      = local.pub_hosted_zone_id[0]

  # ALB
  alb_name          = local.alb_name
  alb_listener_arn  = local.alb_listener_arn
  alb_source_sg_id  = local.alb_sg_id
  alb_host_pattern  = ["${var.subdomain}"]
  health_check_path = "/health"
  internal          = true

  # Metrics
  otel_agent_enabled = false

  # Container
  docker_image            = var.project
  docker_image_tag        = var.docker_image_tag
  required_cpu            = var.required_cpu
  required_memory         = var.required_memory
  container_port          = 80
  container_desired_count = var.asg_min_capacity



  # Env + Secrets
  # task_env_vars = {

  # }

  #task_secrets = {
  # }
}