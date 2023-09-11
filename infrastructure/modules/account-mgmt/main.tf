module "aft" {
  source = "git@github.com:aws-ia/terraform-aws-control_tower_account_factory.git"

  # Required Parameters
  ct_management_account_id    = "427071048654"
  log_archive_account_id      = "427071048654"
  audit_account_id            = "427071048654"
  aft_management_account_id   = "427071048654"
  ct_home_region              = "us-east-1"
  tf_backend_secondary_region = "us-west-2"

  # Optional Parameters
  terraform_distribution = "oss"
  vcs_provider           = "github"

  # Optional Feature Flags
  aft_feature_delete_default_vpcs_enabled = false
  aft_feature_cloudtrail_data_events      = false
  aft_feature_enterprise_support          = false
}

module "account-setup" {
  source  = "daringway/account-setup/aws"
  version = "3.1.0"

  depends_on = [module.aft]

  cloudtrail_enabled = true
  default_security_group_managed = true
  log_bucket_enabled = true
}