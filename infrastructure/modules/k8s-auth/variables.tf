variable "aws_account_id" {
    description = "The Accout ID for the Terraform Code to apply"
    type = string
}

variable "aws_profile_alias" {
    description = "The alias for aws credential stored"
    type = string
}

variable "aws_default_region" {
    description = "the default region for the aws configurations"
    type = string
}

variable "iam_user_arn_terraform" {
  description = "Terraform IAM User's ARN"
  type        = string
}

variable "iam_user_arn_root" {
  description = "root IAM User's ARN"
  type        = string
}

variable "cluster_name" {
  description = "target cluster's name"
  type        = string
}

variable "federated_user" {
  description = "federated user id for SSO access"
  type = string
}

variable "spacelift_role_name" {
  description = "the name of pre-created spacelift role in environment"
  type = string
}

variable "assumed_cluster_role" {
  description = "For dev, we use cluster_developer_role, for the rest, cluster_viewer_role is used"
  type = string
}
