module "k8s" {
  source = "../modules/k8s-infra"

  eks_cluster_name = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  eks_node_desired_capacity = var.eks_node_desired_capacity
  eks_node_max_capacity = var.eks_node_max_capacity
  eks_node_min_capacity = var.eks_node_min_capacity
  eks_node_key_name = var.eks_node_key_name
  eks_node_instance_type = var.eks_node_instance_type
  default_security_group_name = var.default_security_group_name
  eks_node_volume_size = var.eks_node_volume_size
  manage_default_security_group = var.manage_default_security_group
  
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  single_nat_gateway = var.single_nat_gateway
  enable_nat_gateway = var.enable_nat_gateway
  availability_zones = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  
}

module "k8s-app" {
  source = "../modules/k8s-app"

  repo-name = var.repo-name
  kubernetes_deployment_name = var.kubernetes_deployment_name
}

module "k8s-auth" {
  source = "../modules/k8s-auth"
  cluster_name = var.eks_cluster_name
}
