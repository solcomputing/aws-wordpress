data "aws_iam_policy_document" "ecr_RW" {
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

resource "aws_iam_policy" "ecr_RW" {
  name   = "aws-${var.entity}${var.group_name}EcrGroupPolicy-RW"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr_RW.json
}
