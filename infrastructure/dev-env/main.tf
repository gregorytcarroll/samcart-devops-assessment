module "networking" {
  source = "../modules/networking"
}

module "k8s" {
  source = "../modules/k8s-infra"

  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.subnets_ids
  control_plane_subnet_ids = module.networking.control_plane_subnets_ids
}

module "account-creator" {
  source = "../modules/account-mgmt"
}



