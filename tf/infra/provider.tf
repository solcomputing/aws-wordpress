
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
      name = "DST_%WORKSPACE%"
    }
  }
}

provider "vault" {
  address = var.VAULT_ADDR
  token   = var.VAULT_TOKEN
}

data "vault_generic_secret" "aws_auth" {
  path = "secret/aws/%WORKSPACE%"
}

provider "aws" {
    access_key=data.vault_generic_secret.aws_auth.data["AWS_ACCESS_KEY_terraform_admin_%WORKSPACE%"]
    secret_key=data.vault_generic_secret.aws_auth.data["AWS_SECRET_KEY_terraform_admin_%WORKSPACE%"]
    region = module.environment.env.vpc_region
}