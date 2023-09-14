provider "aws" {
    region              = var.region
    assume_role {
       role_arn = "arn:aws:iam::427071048654:role/github-actions-admin"
    }
}

data "aws_eks_cluster" "target-cluster" {
   name = var.cluster_name
}

data "aws_eks_cluster_auth" "target-cluster-auth" {
    name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.target-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.target-cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.target-cluster-auth.token
}
