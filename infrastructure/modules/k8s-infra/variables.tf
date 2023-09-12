variable "vpc_id" {
    type = string
 }

 variable "cluster_name" {
     type = string
 }
  
variable "subnet_ids" {
    type = list(string)
}

variable "iam_policy_prefixes" {
  type    = list(string)
  default = [
    "${local.iam_role_policy_prefix}/AmazonEKSWorkerNodePolicy",
    "${local.iam_role_policy_prefix}/AmazonEC2ContainerRegistryReadOnly",
  ]
}