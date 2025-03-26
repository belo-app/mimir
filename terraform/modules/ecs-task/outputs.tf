output "task_sg_id" {
  value = module.ecs_task_sg.security_group_id
}
output "task_container_port" {
  value = var.container_port
}
