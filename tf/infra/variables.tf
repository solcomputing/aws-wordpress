variable "PROJECT_NAME" {
default     = "WORDPRESS"
description = "The environment which to fetch the configuration for."
type = string
}

variable "VAULT_ADDR" {
default     = "https://aws-wordpress-vault-cluster-public-vault-04cc1d86.d4f84486.z1.hashicorp.cloud:8200"
description = "Hashicorp Vault Token"
type = string
}

variable "VAULT_TOKEN" {
default     = "hvs.CAESIMQi_PSNdLt72_Ph74zh6ZTlNX7GdCh2WBUX1w8a6wkBGigKImh2cy5TMHFiQlVUNlRPbkFqUzR0TWF4SGVqMkEuYkhudmsQzr8B"
description = "Hashicorp Vault Token"
type = string
}

variable "ORGANISATION" {
default     = "SOLCOMPUTING"
description = "Hashicorp IO organisation name to provide"
type = string
}

variable "AWS_ACCESS_KEY_"{}
variable "AWS_SECRET_KEY_"{}