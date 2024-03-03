resource "aws_iam_user" "administrator" {
  count    = length(var.group_iam.group.group_members)
  name     = var.group_iam.group.group_members[count.index]
}

resource "aws_iam_access_key" "administrator" {
  count    = length(var.group_iam.group.group_members)
  user     = var.group_iam.group.group_members[count.index]
}

resource "aws_iam_group" "group" {
    name = "${var.group_name}"
}

data "aws_iam_policy_document" "group" {
  statement {
    actions = [
     "iam:GetGroup",
     "iam:CreateGroup",
     "iam:AddUserToGroup",
     "iam:DeleteGroup",
     "iam:UpdateGroup",
     "iam:AttachGroupPolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "group" {
  name   = "${var.group_name}AWSCreateGroupPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.group.json
}

resource "aws_iam_policy_attachment" "group-attach-policies" {
  count = length(var.policies)
  name  = join("_", ["policygroup-attachment", var.group_name, element(var.policies, count.index)])
  groups     = [aws_iam_group.group.name]
  policy_arn = element(var.policies, count.index)
}


resource "aws_iam_policy_attachment" "group-attach-policy" {
  name       = join("_", ["policygroup-attachment", var.group_name, aws_iam_policy.group.arn])
  groups     = [aws_iam_group.group.name]
  policy_arn = aws_iam_policy.group.arn
}

#resource "pgp_key" "pgp_gen" {
#  count    = length(var.group_iam.group.group_members)
#  name    = var.group_iam.group.group_members[count.index]
#  email   = join("@", [var.group_iam.group.group_members[count.index], var.organisation])
#  comment = "Generated PGP Key for ${var.group_iam.group.group_members[count.index]}"
#}

resource "aws_iam_user_login_profile" "administrator" {
    count    = length(var.group_iam.group.group_members)
    user     = var.group_iam.group.group_members[count.index]
    pgp_key  = "keybase:macdrorepo"
    password_reset_required = true
}

resource "aws_iam_group_membership" "group" {
   name       = var.group_name
   group      = aws_iam_group.group.name
   users      = var.group_iam.group.group_members
   depends_on = [ 
    aws_iam_group.group
   ]
}

