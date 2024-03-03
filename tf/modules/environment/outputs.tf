output "env" {
  value = local.environments[var.environment]
}

output "usersgroup" {
  value = local.usersgroup
}