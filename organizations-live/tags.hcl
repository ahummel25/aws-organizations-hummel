# Tags defined here are applied to all resources via the AWS provider default_tags
# (see terragrunt.hcl generate "provider") and are merged into Terraform inputs.
# Add or edit keys below; keep key names consistent with your org's tagging standards.

locals {
  account_vars = read_terragrunt_config("account.hcl")
  region_vars  = read_terragrunt_config("region.hcl")
  common_tags = {
    Application = "Infrastructure"
    Project     = "AWS Organization"
    Environment = "organization"
    Owner       = get_env("TAG_OWNER", "Andrew Hummel")
    ManagedBy   = "Terragrunt"
    Account     = local.account_vars.locals.account_name
    Region      = local.region_vars.locals.aws_region
  }
}

