# Specific data sources



# General data sources

data "aws_region" "current" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/vpc.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "subnets" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/subnets.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "ecs_cluster" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/ecs-cluster.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "route_53" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/dns.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/s3.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "service_alb" {
  backend = "s3"
  config = {
    bucket = "belo-terraform-states-svc-us-east-2"
    key    = "bedrock/alb-svc.tfstate"
    region = "us-east-2"
  }
}
