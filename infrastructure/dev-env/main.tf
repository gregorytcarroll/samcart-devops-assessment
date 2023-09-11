
module "networking" {
  source = "../modules/networking"
}

module "k8s" {
  source = "../modules/k8s-infra"

  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids
}

module "account-creator" {
  source = "../modules/account-mgmt"
}



