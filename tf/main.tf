
module "environment" {
    source      = "./modules/environment"
    environment = terraform.workspace
}

provider "aws" {
# Plan to retrieve from vault 
    access_key=var.AWS_ACCESS_KEY
    secret_key=var.AWS_SECRET_KEY
    region = module.environment.env.vpc_region
}

module "vpc" {
    source             = "./modules/aws/network/vpc"
    vpc_name           = "${module.environment.env.vpc_name}_${var.project_name}"
    vpc_cidr_block     = module.environment.env.vpc_cidr_block
    vpc_public_subnet  = module.environment.env.vpc_public_subnet
    vpc_app_subnet     = module.environment.env.vpc_app_subnet
    vpc_db_subnet      = module.environment.env.vpc_db_subnet
    vpc_azs            = module.environment.env.azs
}
