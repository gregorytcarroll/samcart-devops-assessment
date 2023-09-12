module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"
  
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id

  # EKS worker node settings (customize as needed)
  node_groups = {
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


resource "aws_lb" "example_lb" {
  name               = "eks-lb-ext"
  internal           = false  # Set to true if internal LB
  load_balancer_type = "application"

  enable_deletion_protection = true 
  enable_http2               = true

  subnets = module.vpc.private_subnets_ids

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "eks-lb-ext"
  }
}


resource "aws_s3_bucket" "eks_bucket" {
  bucket = "eks-bucket"
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

