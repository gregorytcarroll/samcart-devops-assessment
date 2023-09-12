## Networking ##

vpc_name = "vpc-serverless"
vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnets = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
public_subnets = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
enable_nat_gateway = true
single_nat_gateway = true
enable_dns_hostnames = true
manage_default_security_group = true
default_security_group_name = "vpc-serverless-security-group"

## K8s Infra ##

cluster_name = "vpc-serverless-cluster"
subnet_ids = [ "10.0.2.0/24","10.0.4.0/24","10.0.6.0/24" ]