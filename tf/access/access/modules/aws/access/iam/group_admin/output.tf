output  "aws_iam_group_arn" {
  value = aws_iam_group.group.arn
}

output "passwords" {
  value = [aws_iam_user_login_profile.administrator[*].encrypted_password]
}