
output "eks_cluster_endpoint" {
  value = module.eks_cluster.eks_cluster_endpoint
}

output "eks_cluster_kubeconfig" {
  value = module.eks_cluster.kubeconfig_filename
}

output "lb_dns_name" {
  value = aws_lb.example_lb.dns_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.example_bucket.id
}