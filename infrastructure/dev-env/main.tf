module "k8s" {
  source = "../modules/k8s-infra"

  depends_on = [ module.networking ]

  cluster_name = var.eks_cluster_name
  
}
