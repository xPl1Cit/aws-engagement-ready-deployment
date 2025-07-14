terraform {
  cloud {
    organization = "aws-final-al"

    workspaces {
      name = "AWS-Final-Project-AL"
    }
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