resource "aws_s3_bucket" "s3store" {
  bucket	= "${var.bucket_name}"
}


resource "aws_s3_bucket_acl" "s3store" {
  bucket = aws_s3_bucket.s3store.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3store" {
  bucket  = aws_s3_bucket.s3store.id

  versioning_configuration  {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}