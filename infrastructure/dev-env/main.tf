module "k8s" {
  source = "../modules/k8s-infra"

  depends_on = [ module.networking ]

  cluster_name = var.cluster_name
  
}

# module "account-creator" {
#   source = "../modules/account-mgmt"
# }
# Removed due to Github Actions issues



