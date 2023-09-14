module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.27"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = false

  # EKS worker node settings (customize as needed)
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t2.micro"
      key_name         = "eks-key"
      volume_size      = 20
    }
  }
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "eks-key"
  create_private_key = true
}


resource "aws_lb" "dev_lb" {
  name               = "eks-lb-ext"
  internal           = false  # Set to true if internal LB
  load_balancer_type = "application"

  enable_deletion_protection = true 
  enable_http2               = true

  subnets = module.vpc.public_subnets

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "eks-lb-ext"
  }
}


resource "aws_s3_bucket" "eks_bucket" {
  bucket = "dev-eks-bucket"
  acl    = "private" 

  # Enable versioning, logging, and encryption options if desired
  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }
}

module "vpc" {
  source                        = "terraform-aws-modules/vpc/aws"
  version                       = "5.1.2"
  name                          = var.vpc_name
  cidr                          = var.vpc_cidr
  azs                           = var.availability_zones
  private_subnets               = var.private_subnets
  public_subnets                = var.public_subnets
  enable_nat_gateway            = var.enable_nat_gateway
  single_nat_gateway            = var.single_nat_gateway
  enable_dns_hostnames          = var.enable_dns_hostnames
  manage_default_security_group = var.manage_default_security_group
  default_security_group_name   = var.default_security_group_name
  map_public_ip_on_launch       = true
  
  public_subnet_tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
    "kubernetes.io/role/elb"               = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
    "kubernetes.io/role/internal-elb"      = "1"
  }

  tags = {
    "kubernetes.io/cluster/vpc-serverless" = "shared"
  }

}

###################
# Kubernetes Auth #
###################

locals {
    yaml_quote = ""

    roles_to_map = [
        {
            rolearn = "arn:aws:iam::123456789012:user/kube-admin"
            username = "system:node:{{EC2PrivateDNSName}}"
            groups = [
                "system:bootstrappers",
                "system:nodes"
            ]
        }
    ]
}
