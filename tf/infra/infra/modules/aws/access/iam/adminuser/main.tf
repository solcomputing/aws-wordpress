
resource "aws_iam_user" "administrator" {
    name = "${var.accountbuilder}"
}

resource "aws_iam_user_login_profile" "administrator" {
  user                    = aws_iam_user.administrator.name
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "attach-user" {
  for_each   = var.policies
  user       = var.accountbuilder
  policy_arn = each.value
  depends_on = [
    aws_iam_user.administrator
  ]
}