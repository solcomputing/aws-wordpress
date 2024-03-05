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
default     = "hvs.CAESIHv5ZbULybH8ofrKcW1cnlx230C6K_NWalegJ5sQPionGicKImh2cy42eHNPU1FqVXp6V3lRRUVINWVsN201M24uYkhudmsQ1Fc"
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