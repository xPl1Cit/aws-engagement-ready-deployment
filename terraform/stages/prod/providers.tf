terraform {
  backend "s3" {
    bucket = "final-aws-al-terraform-state"
    key    = "eks/cluster/terraform-prod.tfstate"
    region = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region = var.region
}