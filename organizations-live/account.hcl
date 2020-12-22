locals {
  account_name   = "master-account"
  aws_account_id = get_env("AWS_MASTER_ACCOUNT_ID")
  aws_profile    = "" # set to a named profile (e.g. "master-account-profile") to use one; leave empty for default credential chain
}
