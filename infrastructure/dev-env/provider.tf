terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    terraform = {
      source  = "hashicorp/terraform"
      version = ">= 1.0"
    }
  }
}

terraform {
  backend "s3" {
    region = "us-east-1"
    bucket  = "terraform-states-gtest"
    key     = "state/samcart-test.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

