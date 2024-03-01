locals {
preprod = {
    node_pool_machine_type = "t3.2xlarge"
    azs = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name           = "VPC_PP"
    vpc_region         = "eu-west-3"
    vpc_cidr_block     = "10.0.0.0/16"
    vpc_public_subnet  = ["10.0.112.0/24", "10.0.114.0/24",  "10.0.116.0/24"]
    vpc_app_subnet     = ["10.0.113.0/24", "10.0.115.0/24",  "10.0.117.0/24"]
    vpc_db_subnet      = ["10.0.118.0/24", "10.0.120.0/24", "10.0.122.0/24"]
}
}
