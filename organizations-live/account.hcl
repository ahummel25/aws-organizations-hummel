locals {
  account_name   = "master-account"
  aws_account_id = get_env("AWS_MASTER_ACCOUNT_ID")
  aws_profile    = "master-account-profile"
}
