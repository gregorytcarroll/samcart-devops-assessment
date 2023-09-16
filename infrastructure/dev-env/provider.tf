terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.14.0"
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

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_name
}

provider "kubernetes" {
  alias           = "kube-admin"
  load_config_file = false

  host = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s-cluster.certificate_authority.0.data)
  token = data.aws_eks_cluster_auth.cluster.token

}

