
module "networking" {
  source = "../modules/networking"

  project_id = var.project_id
  region = var.region
}

module "k8s" {
  source = "../modules/k8s"

  project_id = var.project_id
  region = var.region
}

module "account-creator" {
  source = "../modules/account-mgmt"

  project_id = var.project_id
  region = var.region
}

