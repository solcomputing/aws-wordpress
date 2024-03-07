
terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.24.1"
    }
  }
  cloud {
    organization = "SOLCOMPUTING"
    workspaces {
      name = "iam"
    }
  }
}

provider "vault" {
  address = var.VAULT_ADDR
  token   = var.VAULT_TOKEN
}

data "vault_generic_secret" "aws_auth" {
  path = "secret/aws/default"
}

provider "aws" {
# Plan to retrieve from vault 
    access_key=data.vault_generic_secret.aws_auth.data["AWS_ACCESS_KEY"]
    secret_key=data.vault_generic_secret.aws_auth.data["AWS_SECRET_KEY"]
    region=module.settings.env.region
}