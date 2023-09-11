
module "networking" {
  source = "../modules/networking"

  region = var.region
}

module "k8s" {
  source = "../modules/k8s-infra"

  region = var.region
}

module "account-creator" {
  source = "../modules/account-mgmt"
}



