output "aws_iam_role_arn" {
  description = "ARN of the IAM role that is being utilized by controller."
  value       = aws_iam_role.this.arn
}