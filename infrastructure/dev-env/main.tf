module "k8s" {
  source = "../modules/k8s-infra"

  depends_on = [ module.networking ]

  eks_cluster_name = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  eks_node_desired_capacity = var.eks_node_desired_capacity
  eks_node_max_capacity = var.eks_node_max_capacity
  eks_node_min_capacity = var.eks_node_min_capacity
  eks_node_key_name = var.eks_node_key_name
  eks_node_instance_type = var.eks_node_instance_type
  

  
}
