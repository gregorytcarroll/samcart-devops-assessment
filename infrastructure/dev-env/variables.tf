## K8s ##

variable "cluster_name" {
     type = string
     default = "dev-env-cluster"
 }

variable "vpc_id" {
     type = string
 }
   
variable "subnet_ids" {
        type = list(string)
 }

## Networking ##

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets CIDR blocks"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway for all private subnets"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames"
  type        = bool
}

variable "manage_default_security_group" {
  description = "Manage the default security group for the VPC"
  type        = bool
}

variable "default_security_group_name" {
  description = "Name of the default security group"
  type        = string
}
