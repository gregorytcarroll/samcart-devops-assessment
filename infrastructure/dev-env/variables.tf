# Variables for the EKS Cluster Module

variable "eks_cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
}

variable "eks_cluster_version" {
  description = "EKS cluster Kubernetes version"
  type        = string
}

variable "eks_node_desired_capacity" {
  description = "Desired capacity for EKS worker nodes"
  type        = number
}

variable "eks_node_max_capacity" {
  description = "Max capacity for EKS worker nodes"
  type        = number
}

variable "eks_node_min_capacity" {
  description = "Min capacity for EKS worker nodes"
  type        = number
}

variable "eks_node_instance_type" {
  description = "Instance type for EKS worker nodes"
  type        = string
}

variable "eks_node_key_name" {
  description = "SSH key name for EKS worker nodes"
  type        = string
}

variable "eks_node_volume_size" {
  description = "Volume size for EKS worker nodes"
  type        = number
}

# Variables for the VPC Module

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT gateway for private subnets"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT gateway for all private subnets"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames for the VPC"
  type        = bool
}

variable "manage_default_security_group" {
  description = "Whether to manage the default security group"
  type        = bool
}

variable "default_security_group_name" {
  description = "Name for the default security group"
  type        = string
}

# Variables for the ECR Module

variable "repo-name" {
    description = "Name of the ECR repository"
    type        = string
}

variable "kubernetes_deployment_name" {
    description = "Name of the Kubernetes deployment"
    type        = string
}
