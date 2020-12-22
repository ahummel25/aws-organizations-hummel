output "account_id" {
  value = aws_organizations_account.account.id
}

output "account_alias" {
  value = var.account_alias
}
