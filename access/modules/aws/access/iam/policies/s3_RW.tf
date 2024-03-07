data "aws_iam_policy_document" "S3Bucket_RW" {
  statement {
    actions = [
        "S3:CreateBucket",
        "S3:HeadBucket",
        "S3:ListBucket",
        "S3:GetBucketPolicy",
        "S3:GetBucketAcl",
        "S3:GetBucketCors",
        "S3:GetBucketWebsite",
        "S3:GetBucketVersioning",
        "S3:GetBucketAccelerateConfiguration",
        "S3:ListAllMyBuckets"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "S3Bucket_RW" {
   name        = "aws-${var.entity}S3BucketPolicy-RW"
   description = "aws-${var.entity}S3BucketPolicy-RW"
   policy      = data.aws_iam_policy_document.S3Bucket_RW.json
}
