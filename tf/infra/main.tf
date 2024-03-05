
module "environment" {
    source             = "./modules/environment"
    environment        = terraform.workspace
}

data "aws_iam_user" "admin" {
    user_name          = module.environment.env.defaultaccount
}

#module "_S3_" {
#    source             = "./modules/aws/global/s3"
#    bucket_name        = replace(lower(join("-", ["s3","registry",
#                                           module.environment.env.organization, 
#                                           module.environment.env.accountbuilder])),"_", "-")
#}

module "_DOCKER_" {
    source             = "./modules/aws/global/ecr"
    organization       = module.environment.env.organization
    repos              = ["development", "preprod", "prod"]
}

module "_VPC_" {
    source             = "./modules/aws/network/vpc"
    vpc_name           = "${module.environment.env.vpc_name}_${var.PROJECT_NAME}_${terraform.workspace}"
    vpc_cidr_block     = module.environment.env.vpc_cidr_block
    vpc_public_subnet  = module.environment.env.vpc_public_subnet
    vpc_app_subnet     = module.environment.env.vpc_app_subnet
    vpc_db_subnet      = module.environment.env.vpc_db_subnet
    vpc_azs            = module.environment.env.azs
}