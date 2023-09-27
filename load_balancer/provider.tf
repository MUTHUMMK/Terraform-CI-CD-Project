terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Terraform if takes AWS credentials from the Jenkins 

provider "aws" {
  region = var.alb_region
}