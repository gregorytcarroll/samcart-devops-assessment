
module "networking" {
  source = "../modules/networking"
}

module "k8s" {
  source = "../modules/k8s-infra"
}

module "account-creator" {
  source = "../modules/account-mgmt"
}



