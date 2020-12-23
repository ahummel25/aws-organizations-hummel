output "admin_user_master-aws_iam_user-credentials" {
  description = "The user's credentials"
  value       = module.admin_user_master.aws_iam_user-credentials
}

output "master-account-accounts" {
  description = "From the Terraform docs: 'List of organization accounts including the master account.'"
  value       = module.root.accounts
}

output "master-account-non-master-accounts" {
  description = "From the Terraform docs: 'List of organization accounts including the master account.'"
  value       = module.root.non-master-accounts
}

output "master-account-roots" {
  description = "From the Terraform docs: 'List of organization roots. (...)'"
  value       = module.root.roots
}

output "ou-accounts" {
  description = "From the Terraform docs: 'List of child accounts for this Organizational Unit."
  value       = module.ou-1.accounts
}
output "ou-id" {
  description = "From the Terraform docs: 'Identifier of the organization unit'"
  value       = module.ou-1.id
}