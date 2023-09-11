variable "vpc_id" {
    type = string
    default = "vpc-4570433d"
}

 variable "cluster_name" {
     type = string
     default = "dev-env-cluster"
 }
  
variable "subnet_ids" {
    type = list(string)
}
  
variable "control_plane_subnet_ids" {
    type = list(string)
}
