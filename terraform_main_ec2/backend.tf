terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }

  backend "s3" {
    bucket  = "younes-ec2-tfstate-2026"
    key     = "ec2/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_version = ">= 1.6.3"
}

provider "aws" {
  region = "us-east-1"
}


