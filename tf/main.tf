
module "environment" {
    source      = "./modules/environment"
    environment = terraform.workspace
}

data "aws_iam_user" "admin" {
    user_name          = module.environment.env.defaultaccount
}

module "iam_policies" {
    source             = "./modules/aws/access/iam/policies"
    arnaccount         = data.aws_iam_user.admin.arn
    entity             = module.environment.env.organisation
    region             = module.environment.env.vpc_region

}

module "iam_admin_groups" {
    source             = "./modules/aws/access/iam/group_admin"
    organisation       = module.environment.usersgroup.group.organisation
    group_name         = module.environment.usersgroup.group.group_name
    group_iam          = module.environment.usersgroup
    policies           = module.iam_policies.policies_arn
    depends_on         = [
        module.iam_policies
    ]
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

#module "eks" {
#    source             = "./modules/aws/eks"
#    eks_cluster_region = module.environment.env.vpc_region
#    eks_policy_user    = module.environment.env.idaccountbuilder
#}
