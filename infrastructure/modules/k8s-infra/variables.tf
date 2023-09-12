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
}