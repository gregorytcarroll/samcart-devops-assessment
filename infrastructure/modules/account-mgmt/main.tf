module "account-creation" {
  source  = "tedilabs/account/aws//modules/account"
  version = "0.27.1"
  
  name = "samcart-assessment"
}

module "account-setup" {
  source  = "daringway/account-setup/aws"
  version = "3.1.0"

  depends_on = [module.account-creation]

  cloudtrail_enabled = true
  default_security_group_managed = true
  log_bucket_enabled = true
}