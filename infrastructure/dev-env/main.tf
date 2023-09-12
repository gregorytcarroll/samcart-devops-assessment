module "networking" {
  source = "../modules/networking"
}

module "k8s" {
  source = "../modules/k8s-infra"

  depends_on = [ module.networking ]

  vpc_id = module.networking.vpc_id
}

# module "account-creator" {
#   source = "../modules/account-mgmt"
# }
# Removed due to Github Actions issues



