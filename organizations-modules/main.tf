### ORGANIZATION - BEGIN
# From the AWS docs: "An entity that you create to consolidate your AWS accounts so that you can administer them as a single unit."
module "root" {
  source               = "./organizations"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}
### ORGANIZATION - END

### GROUPS - START
module "administrators" {
  source                     = "./iam-groups"
  name                       = "administrators"
  enable-AdministratorAccess = true
}
### GROUPS - END

## ORGANIZATION UNITS - START
module "ou-1" {
  source    = "./organizations-organizational-units"
  name      = "ou-1"
  parent_id = module.root.roots.0.id
}
## ORGANIZATION UNITS - END

### USERS - START
module "admin_user_master" {
  source        = "./iam-users"
  name          = "admin_user_master"
  groups        = ["administrators"]
  force_destroy = true
  pgp_key       = "keybase:aws_keybase_user" # SWAP admin_user_1 FOR YOUR KEYBASE USERNAME
}
### USERS - END

### ACCOUNTS - START
locals {
  role_name = "adminAssumeRole"
}

module "hummel-non-prod" {
  source    = "./organizations-accounts"
  name      = "hummel_non_prod"
  email     = "ahummel25+non-prod2@gmail.com" # SWAP YOUR_EMAIL+account-dev@YOUR_DOMAIN.TLD FOR YOUR EMAIL ADDRESS
  parent_id = module.ou-1.id
  role_name = local.role_name # NB you won't be able to change this role name via Terraform once created
}

module "account-prod" {
  source    = "./organizations-accounts"
  name      = "hummel_prod"
  email     = "ahummel25+prod2@gmail.com" # SWAP YOUR_EMAIL+account-dev@YOUR_DOMAIN.TLD FOR YOUR EMAIL ADDRESS
  parent_id = module.ou-1.id
  role_name = local.role_name # NB you won't be able to change this role name via Terraform once created
}
# ### ACCOUNTS - END
