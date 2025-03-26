locals {
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  pub_subnets        = [for _, v in data.terraform_remote_state.subnets.outputs.public_subnets_ids : v]
  prv_subnets        = [for _, v in data.terraform_remote_state.subnets.outputs.private_subnets_ids : v]
  ecs_cluster        = data.terraform_remote_state.ecs_cluster.outputs.ecs_cluster_name
  pub_hosted_zone_id = data.terraform_remote_state.route_53.outputs.pub_zone_id
  access_logs_bucket = data.terraform_remote_state.s3.outputs.access_logs_bucket
  alb_name           = data.terraform_remote_state.service_alb.outputs.alb_services_name
  alb_sg_id          = data.terraform_remote_state.service_alb.outputs.alb_services_sg_id
  alb_listener_arn   = data.terraform_remote_state.service_alb.outputs.alb_listener_arn
}
