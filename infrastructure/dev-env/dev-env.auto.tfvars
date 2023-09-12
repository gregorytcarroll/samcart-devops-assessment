# EKS cluster variables
eks_cluster_name            = "dev-eks-cluster"
eks_cluster_version         = "1.21"
eks_node_desired_capacity   = 2
eks_node_max_capacity       = 3
eks_node_min_capacity       = 1
eks_node_instance_type      = "t2.micro"
eks_node_key_name           = "dev-key-pair"
eks_node_volume_size        = 20

# VPC variables
vpc_name                    = "vpc-serverless"
vpc_cidr                    = "10.0.0.0/16"
availability_zones          = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets             = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
public_subnets              = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
enable_nat_gateway          = true
single_nat_gateway          = true
enable_dns_hostnames        = true
manage_default_security_group = true
default_security_group_name = "vpc-serverless-security-group"
