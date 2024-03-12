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
default     = "hvs.CAESIOId84wv-lbMvEEfC10AnlteT3-CjDv0-0Rp-D0gnDUHGigKImh2cy5UNElCRGx2a3lFeXhKaVBvekd5T0ZzbTMuYkhudmsQ3aEE"
description = "Hashicorp Vault Token"
type = string
}

variable "ORGANISATION" {
default     = "SOLCOMPUTING"
description = "Hashicorp IO organisation name to provide"
type = string
}