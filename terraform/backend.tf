//--------------------------------------
//---------Backend & Providers ---------
//--------------------------------------
terraform {
  backend "s3" {
    encrypt = true
    region  = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Scope       = "nginx-internal-webs"
      Team        = "technology"
      Environment = var.environment
      Provisioned = "terraform"
    }
  }

  assume_role {
    role_arn     = var.role_arn
    session_name = "terraform-session"
  }
}
