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
