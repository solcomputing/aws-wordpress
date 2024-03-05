output "arn_keyAccess_policy" {
  value = aws_iam_policy.keyAccess.arn
}

output "arn_ecr_policy" {
  value = aws_iam_policy.ecr.arn
}

output "arn_vpcPolicy_policy" {
  value = aws_iam_policy.ecr.arn
}

output "arn_load_balancer_management_policy" {
  value = aws_iam_policy.ecr.arn
}

output "arn_policies" {
  value = [ 
            aws_iam_policy.keyAccess.arn,
            aws_iam_policy.ecr.arn,
            aws_iam_policy.vpcPolicy.arn,
            aws_iam_policy.groupPolicy.arn,
            aws_iam_policy.load_balancer_management.arn
           ]
}