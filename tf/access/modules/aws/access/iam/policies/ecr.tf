data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
		"ecr:CreateRepository",
		"ecr:DescribeRepositories",
		"ecr:ListTagsForResource",
		"ecr:DeleteRepository"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecr" {
  name   = "aws-${var.entity}${var.group_name}EcrGroupPolicy"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr.json
}