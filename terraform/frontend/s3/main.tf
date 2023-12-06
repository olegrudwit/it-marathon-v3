resource "aws_s3_bucket" "marathon" {
  bucket = "${var.name_prefix}-frontend"

  force_destroy = true

  tags = {
    created_by  = "terraform"
    application = "dev-user"
  }
}

resource "aws_s3_bucket_website_configuration" "marathon" {
  bucket = aws_s3_bucket.marathon.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "marathon" {
  bucket = aws_s3_bucket.marathon.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_policy" "marathon" {
  bucket = aws_s3_bucket.marathon.id
  policy = data.aws_iam_policy_document.marathon.json
}

data "aws_iam_policy_document" "marathon" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    effect    = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.marathon.arn}/*"]
  }
}

resource "aws_s3_bucket_public_access_block" "marathon" {
  bucket = aws_s3_bucket.marathon.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "marathon" {
  bucket = aws_s3_bucket.marathon.id
  acl    = "public-read"
}
