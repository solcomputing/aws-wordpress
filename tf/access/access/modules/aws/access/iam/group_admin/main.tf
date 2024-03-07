resource "aws_iam_user" "administrator" {
  count    = length(var.group_iam.group.group_members)
  name     = var.group_iam.group.group_members[count.index]
}

resource "aws_iam_group" "group" {
    name = "${var.group_name}"
}


resource "aws_iam_policy_attachment" "group-attach-policies" {
  count = length(var.policies)
  name  = join("_", ["policygroup-attachment", var.group_name, element(var.policies, count.index)])
  groups     = [aws_iam_group.group.name]
  policy_arn = element(var.policies, count.index)
}

resource "aws_iam_access_key" "administrator" {
  count    = length(var.group_iam.group.group_members)
  user     = var.group_iam.group.group_members[count.index]
      depends_on = [
               aws_iam_user.administrator
    ]
}

resource "aws_iam_user_login_profile" "administrator" {
    count     = length(var.group_iam.group.group_members)
    user      = var.group_iam.group.group_members[count.index]
#    pgp_key   = "keybase:${var.group_iam.group.group_members[count.index]}"
    password_reset_required = false
    depends_on = [
               aws_iam_access_key.administrator
    ]
}

resource "aws_iam_group_membership" "group" {
   name       = var.group_name
   group      = aws_iam_group.group.name
   users      = var.group_iam.group.group_members
   depends_on = [ 
    aws_iam_group.group,
    aws_iam_access_key.administrator
   ]
}

resource "vault_generic_secret" "administrator" {
   count        = length(var.group_iam.group.group_members)
   path         = lower(join("/", ["secret/aws", split("_", var.group_iam.group.group_members[count.index])[2]])) 
   disable_read = false
   data_json    = jsonencode({
    "AWS_ACCESS_KEY_${var.group_iam.group.group_members[count.index]}" = aws_iam_access_key.administrator[count.index].id
    "AWS_SECRET_KEY_${var.group_iam.group.group_members[count.index]}" = aws_iam_access_key.administrator[count.index].secret
  })
  depends_on = [ 
    aws_iam_user.administrator,
    aws_iam_group.group,
    aws_iam_access_key.administrator
   ]
}