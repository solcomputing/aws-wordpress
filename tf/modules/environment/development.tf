locals {
development = {
    node_pool_machine_type = "t3.micro"
    region = "eu-west-3"
    azs = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name = "VPC_DEV"
    vpc_public_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    vpc_private_subnet = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  }
}
