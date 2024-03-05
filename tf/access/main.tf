module "settings" {
    source             = "./modules/settings"
    environment        = "settings"
}

data "aws_iam_user" "admin" {
    user_name          = module.settings.env.defaultaccount
}

module "IAM_policies" {
    source             = "./modules/aws/access/iam/policies"
    arnaccount         = data.aws_iam_user.admin.arn
    entity             = module.settings.env.organization
    region             = module.settings.env.region
}

module "IAM_admin_groups" {
    source             = "./modules/aws/access/iam/group_admin"
    organization       = module.settings.env.group.organization
    group_name         = module.settings.env.group.group_name
    group_iam          = module.settings.env
    policies           = module.IAM_policies.arn_policies
    depends_on         = [
        module.IAM_policies
    ]
}