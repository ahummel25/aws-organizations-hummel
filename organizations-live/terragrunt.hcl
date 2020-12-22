locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config("account.hcl")

  # Automatically load region-level variables
  region_vars = read_terragrunt_config("region.hcl")

  tag_vars = read_terragrunt_config("tags.hcl")

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  common_tags  = local.tag_vars.locals.common_tags
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
	provider "aws" {
	region = "${local.aws_region}"
	  # Only these AWS Account IDs may be operated on by this template
	  allowed_account_ids = ["${local.account_id}"]
    profile = "${local.account_vars.locals.aws_profile}"
    default_tags {
      tags = jsondecode("${replace(jsonencode(local.tag_vars.locals.common_tags), "\"", "\\\"")}")
    }
	}
	EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
    required_version = ">= 1.14.0"
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = ">= 6.31.0"
      }
    }
  }
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "aws-orgs-hummel-${local.aws_region}"
    key            = "terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

terraform_binary = "terraform"

terraform {
  source = "..//organizations-modules"
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.common_tags,
)
