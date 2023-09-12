## K8s ##

 variable "cluster_name" {
     type = string
     default = "dev-env-cluster"
 }
  
variable "subnet_ids" {
    type = list(string)
}