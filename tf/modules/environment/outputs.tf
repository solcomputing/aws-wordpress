output "env" {
  value = local.environments["${terraform.workspace}"]
}