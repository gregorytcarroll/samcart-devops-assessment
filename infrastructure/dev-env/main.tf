
module "networking" {
  source = "../modules/networking"
}

module "k8s" {
  source = "../modules/k8s-infra"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.private_subnets
}

module "account-creator" {
  source = "../modules/account-mgmt"
}



