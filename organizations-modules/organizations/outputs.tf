output "accounts" {
  description = "From the Terraform docs: 'List of organization accounts including the master account.'"
  value       = aws_organizations_organization.org.accounts
}

output "non-master-accounts" {
  description = "From the Terraform docs: 'List of organization accounts including the master account.'"
  value       = aws_organizations_organization.org.non_master_accounts
}

output "roots" {
  description = "From the Terraform docs: 'List of organization roots. (...)'"
  value       = aws_organizations_organization.org.roots
}