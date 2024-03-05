data "aws_iam_policy_document" "S3Bucket_RO" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "S3Bucket_RO" {
   name        = "aws-${var.entity}S3BucketPolicy-RO"
   description = "aws-${var.entity}S3BucketPolicy-RO"
   policy      = data.aws_iam_policy_document.S3Bucket_RO.json
}
