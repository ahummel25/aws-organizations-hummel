variable "aws_region" {
  description = "AWS region for provider configuration (e.g. for assume_role). Passed from Terragrunt (region.hcl)."
  type        = string
}
