locals {
development = {
    workspace              = "development"
    organization           = "solcomputing"
    defaultaccount         = "TERRAFORM"
    accountbuilder         = "terraform_dev"
    node_pool_machine_type = "t3.micro"
    azs                    = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
    vpc_name               = "VPC_DEV",
    vpc_region             = "eu-west-3",
    vpc_cidr_block         = "10.0.0.0/16",
    vpc_public_subnet      = ["10.0.2.0/24", "10.0.4.0/24",  "10.0.6.0/24"],
    vpc_app_subnet         = ["10.0.3.0/24", "10.0.5.0/24",  "10.0.7.0/24"],
    vpc_db_subnet          = ["10.0.8.0/24", "10.0.10.0/24", "10.0.12.0/24"]
  }
}
