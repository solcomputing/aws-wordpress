module "settings" {
    source             = "./modules/settings"
    environment        = "settings"
}

data "aws_iam_user" "admin" {
    user_name          = module.settings.env.defaultaccount
}


module "IAM_admin_groups" {
    source             = "./modules/aws/access/iam/group_admin"
    organization       = module.settings.env.group.organization
    group_name         = module.settings.env.group.group_name
    group_iam          = module.settings.env
    policies           = module.IAM_policies.arn_policies_RW
}

module "IAM_policies" {
    source             = "./modules/aws/access/iam/policies"
    arnaccount         = [module.IAM_admin_groups.aws_iam_group_arn]
    entity             = module.settings.env.organization
    region             = module.settings.env.region
}

resource "aws_iam_policy_attachment" "group-attach-policies" {
  count                = length(module.IAM_policies.arn_policies_RW)
  name                 = join("_", ["policygroup-attachment", module.settings.env.group.group_name, element(module.IAM_policies.arn_policies_RW, count.index)])
  groups               = [module.IAM_admin_groups.aws_iam_group_name]
  policy_arn           = element(module.IAM_policies.arn_policies_RW, count.index)
  depends_on           = [
    module.IAM_policies,
    module.IAM_admin_groups
  ]
}
