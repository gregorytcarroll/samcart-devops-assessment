module "account-setup" {
  source  = "daringway/account-setup/aws"
  version = "3.1.0"

  cloudtrail_enabled = true
  default_security_group_managed = true
  log_bucket_enabled = true
}