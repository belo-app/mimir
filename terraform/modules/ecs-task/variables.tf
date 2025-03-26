variable "name" {
  type        = string
  description = "Task name"
}
variable "container_logs_retantion_days" {
  default     = 7
  type        = number
  description = "Number of days logs will be retained"
}
variable "subnets" {
  type = list(string)
}
variable "ecs_cluster_name" {
  type = string
}
variable "docker_registry" {
  default = "539676240085.dkr.ecr.us-east-2.amazonaws.com"
  type    = string
}
variable "docker_image" {
  type = string
}
variable "docker_image_tag" {
  type    = string
  default = "latest"
}
variable "required_cpu" {
  default = 256
  type    = number
}
variable "required_memory" {
  default = 512
  type    = number
}
variable "otel_required_cpu" {
  default = 128
  type    = number
}
variable "otel_required_memory" {
  default = 256
  type    = number
}
variable "container_port" {
  default = 3000
  type    = number
}
variable "container_desired_count" {
  default = 1
  type    = number
}
variable "container_launch_type" {
  default = "EC2" #EC2 o FARGATE
  type    = string
}
variable "alb_listener_arn" {
  type    = string
  default = null
}
variable "vpc_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "task_inline_policy" {
  type    = string
  default = null
}
variable "task_env_vars" {
  type    = map(any)
  default = null
}
variable "task_secrets" {
  type    = map(any)
  default = null
}
variable "alb_source_sg_id" {
  type    = string
  default = null
}
variable "internal" {
  type    = bool
  default = false
}
variable "health_check_path" {
  type    = string
  default = "/health"
}
variable "create_alb_tg" {
  type    = bool
  default = true
}
variable "alb_name" {
  type    = string
  default = null
}
variable "alb_path_pattern" {
  type    = list(string)
  default = []
}
variable "alb_host_pattern" {
  type    = list(string)
  default = []
}
variable "otel_agent_enabled" {
  type    = bool
  default = false
}
variable "dns_zone_id" {
  type = string
}
variable "lock_cache_sg_id" {
  type    = string
  default = null
}

variable "db_cache_sg_id" {
  type    = string
  default = null
}
