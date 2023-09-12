module "networking" {
  source = "../modules/networking"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  manage_default_security_group = var.manage_default_security_group
  default_security_group_name = var.default_security_group_name
}

module "k8s" {
  source = "../modules/k8s-infra"

  depends_on = [ module.networking ]

  cluster_name = var.cluster_name
  subnet_ids      = module.networking.private_subnets_ids
  vpc_id          = module.networking.vpc_id
  
}

# module "account-creator" {
#   source = "../modules/account-mgmt"
# }
# Removed due to Github Actions issues



