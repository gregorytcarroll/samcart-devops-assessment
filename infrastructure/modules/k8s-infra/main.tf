module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.27"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  # EKS worker node settings (customize as needed)
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t2.micro"
      key_name         = "my-key-pair"
      volume_size      = 20
    }
  }
}


resource "aws_lb" "dev_lb" {
  name               = "eks-lb-ext"
  internal           = false  # Set to true if internal LB
  load_balancer_type = "application"

  enable_deletion_protection = true 
  enable_http2               = true

  subnets = module.vpc.private_subnets

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
