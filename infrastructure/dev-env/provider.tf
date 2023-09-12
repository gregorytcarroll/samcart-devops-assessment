terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    region = "us-west-2"
    bucket  = "terraform-states-gtest"
    key     = "state/samcart-test.tfstate"
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "kubernetes" {
  alias           = "eks"
  config_context = "dev-context"
}

