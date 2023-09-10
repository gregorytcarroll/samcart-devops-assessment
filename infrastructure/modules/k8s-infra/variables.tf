variable "vpc_id" {
    type = string
}

variable "cluster_name" {
    type = string
}
  
variable "subnet_ids" {
    type = list(string)
}
  
variable "control_plane_subnet_ids" {
    type = list(string)
}
