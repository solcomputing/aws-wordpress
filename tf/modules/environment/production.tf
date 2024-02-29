locals {
production = {
    node_pool_machine_type = "t3.2xlarge"
    region = "eu-west-1"
    azs = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name = "VPC_PRD"
    vpc_public_subnet  = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
    vpc_private_subnet = ["10.0.40.0/24", "10.0.50.0/24", "10.0.60.0/24"]
}
}
