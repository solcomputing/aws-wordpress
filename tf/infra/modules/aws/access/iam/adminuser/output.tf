output "arn" {
 value = aws_iam_user.administrator.arn
}

output "password" {
  value     = aws_iam_user_login_profile.administrator.password
  sensitive = true
}