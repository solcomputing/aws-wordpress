locals {
    environment = terraform.workspace
}

module "environment" {
    source      = "./modules/environment"
    environment = local.environment
}

provider "aws" {
# Plan to retrieve from vault 
    access_key=var.AWS_ACCESS_KEY
    secret_key=var.AWS_SECRET_KEY
    region = module.environment.env.region
}

module "vpc" {
    source   = "./modules/aws/network/vpc"
    vpc_name = "${module.environment.env.vpc_name}.${var.project_name}"
    vpc_public_subnet  = module.environment.env.vpc_public_subnet
    vpc_private_subnet = module.environment.env.vpc_private_subnet
    vpc_azs = module.environment.env.azs
}
