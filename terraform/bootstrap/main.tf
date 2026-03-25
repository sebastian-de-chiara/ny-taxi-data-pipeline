terraform {
  required_version = "~> 1.14"

  backend "s3" {
    profile      = "ny-taxi"
    bucket       = "ny-taxi-terraform-state-013453151250"
    key          = "bootstrap/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.37.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "ny-taxi"

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = "management"
    }
  }
}

