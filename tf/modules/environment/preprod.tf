locals {
preprod = {
    node_pool_machine_type = "t3.2xlarge"
    region = "eu-west-3"
    azs = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name = "VPC_PP"
    vpc_public_subnet  = ["10.10.0.0/24", "10.20.0.0/24", "10.30.0.0/24"]
    vpc_private_subnet = ["10.40.0.0/24", "10.50.0.0/24", "10.60.0.0/24"]
}
}
