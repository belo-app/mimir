# svc.tfvars
role_arn         = "arn:aws:iam::216119504183:role/terraform-admin-role"
environment      = "svc"
project          = "tech-docs"
domain_name      = "belo.services"
subdomain        = "tech"
docker_image_tag = "latest"

asg_min_capacity = 1
required_cpu     = 256
required_memory  = 256

vpn_access_sg_id = "sg-05cdebda30506937d"
