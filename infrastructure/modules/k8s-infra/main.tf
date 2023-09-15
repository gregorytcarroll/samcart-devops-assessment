module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.27"
  subnet_ids      = module.vpc.public_subnets
  iam_role_arn    = "arn:aws:iam::427071048654:role/github-actions-admin"
  vpc_id          = module.vpc.vpc_id
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = false

  # EKS worker node settings
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


module "application_load_balancer" {
  source  = "infrablocks/application-load-balancer/aws"
  version = "4.0.0"

  region     = "us-west-2"
  vpc_id     = module.vpc.vpc_id
  subnet_ids =  module.vpc.public_subnets

  component             = "eks-app"
  deployment_identifier = "dev"

  domain_name     = "gregs-testing-infra-bot.com"

  listeners = [
    {
      lb_port            = 443
      lb_protocol        = "HTTPS"
      instance_port      = 443
      instance_protocol  = "HTTPS"
      ssl_certificate_id = aws_acm_certificate.cert.arn
    },
    {
      lb_port           = 80
      lb_protocol       = "TCP"
      instance_port     = 80
      instance_protocol = "TCP"
    }
  ]

  access_control = [
    {
      lb_port       = 443
      instance_port = 443
      allow_cidr    = "0.0.0.0/0"
    },
    {
      lb_port       = 80
      instance_port = 80
      allow_cidr    = "0.0.0.0/0"
    }
  ]

  egress_cidrs = "0.0.0.0/0"

  health_check_target              = "HTTPS:443/ping"
  health_check_timeout             = 10
  health_check_interval            = 30
  health_check_unhealthy_threshold = 5
  health_check_healthy_threshold   = 5

  enable_cross_zone_load_balancing = "yes"

  enable_connection_draining  = "yes"
  connection_draining_timeout = 60

  idle_timeout = 60

  expose_to_public_internet = "yes"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "gregs-testing-infra-bot.com"
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
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

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::427071048654:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:gregorytcarroll/*"]
    }
  }
}

resource "aws_iam_role" "github_actions_eks_role" {
  name               = "github-actions-eks-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


resource "aws_ecr_repository" "k8s-app-repo" {
  image_tag_mutability = "MUTABLE"
  name                 = "simple-app-repo"
  tags                 = {} 
  tags_all             = {} 


  encryption_configuration {
          encryption_type = "AES256"
        }

  image_scanning_configuration {
          scan_on_push = true
        }
}