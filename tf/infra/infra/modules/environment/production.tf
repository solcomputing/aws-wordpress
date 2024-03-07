locals {
production = {
    organization           = "solcomputing"
    defaultaccount         = "TERRAFORM"
    accountbuilder         = "terraform_prod"
    node_pool_machine_type = ["t3.2xlarge"]
    azs                    = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name               = "VPC_PRD"
    vpc_region             = "eu-west-1"
    vpc_cidr_block         = "10.0.0.0/16"
    vpc_public_subnet      = ["10.0.22.0/24", "10.0.24.0/24",  "10.0.26.0/24"]
    vpc_app_subnet         = ["10.0.23.0/24", "10.0.25.0/24",  "10.0.27.0/24"]
    vpc_db_subnet          = ["10.0.28.0/24", "10.0.210.0/24", "10.0.212.0/24"]
}
}
