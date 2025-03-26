variable "role_arn" {
  description = "The ARN of the role to assume"
  type        = string
}

variable "environment" {
  description = "Environment to deploy the infrastructure to"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "asg_min_capacity" {
  type        = number
  description = "Min num of tasks for the ASG to scale down to"
  default     = 1
}

variable "required_cpu" {
  type    = number
  default = 512
}

variable "required_memory" {
  type    = number
  default = 512
}

variable "docker_image_tag" {
  description = "Image tag to include in the ECS Task definition"
  type        = string
}

variable "app_listening_port" {
  type    = number
  default = 3000
}

variable "domain_name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "vpn_access_sg_id" {
  type    = string
  default = ""
}
