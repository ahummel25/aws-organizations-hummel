output "id" {
  description = "From the Terraform docs: 'Identifier of the organization unit'"
  value       = aws_organizations_organizational_unit.ou.id
}

output "accounts" {
  description = "From the Terraform docs: 'List of child accounts for this Organizational Unit.'"
  value       = aws_organizations_organizational_unit.ou.accounts
}