provider "vault" {
  address = "http://your-vault-server.com"
  token = "your-vault-token"
}

provider "aws" {
# Plan to retrieve from vault 
    access_key=var.AWS_ACCESS_KEY
    secret_key=var.AWS_SECRET_KEY
    region = module.environment.env.vpc_region
}