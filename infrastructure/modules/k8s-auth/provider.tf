provider "aws" {
    region              = "us-west-2"

}

data "aws_eks_cluster" "target-cluster" {
   name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "target-cluster-auth" {
    name = var.eks_cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.target-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.target-cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.target-cluster-auth.token
}
