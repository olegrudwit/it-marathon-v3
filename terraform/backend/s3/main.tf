resource "aws_s3_bucket" "marathon" {
  bucket = "${var.name_prefix}-java-backend-artifacts"

  force_destroy = true

  tags = {
    created_by  = "terraform"
    application = "dev-user"
  }
}

resource "aws_s3_bucket_versioning" "marathon" {
  bucket = aws_s3_bucket.marathon.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "marathon" {
  bucket = aws_s3_bucket.marathon.id

  rule {
    id = "move-old-to-versions"
    status = "Enabled"

    expiration {
      days = 3
    }
  }
  rule {
    id = "permanent-delete"
    status = "Enabled"

    noncurrent_version_expiration {
      newer_noncurrent_versions = "2"
      noncurrent_days = 2
    }
  }
}

resource "aws_s3_bucket" "marathon_dotnet" {
  bucket = "${var.name_prefix}-dotnet-backend-artifacts"

  force_destroy = true

  tags = {
    created_by  = "terraform"
    application = "dev-user"
  }
}

resource "aws_s3_bucket_versioning" "marathon_dotnet" {
  bucket = aws_s3_bucket.marathon_dotnet.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "marathon_dotnet" {
  bucket = aws_s3_bucket.marathon_dotnet.id

  rule {
    id = "move-old-to-versions"
    status = "Enabled"

    expiration {
      days = 3
    }
  }
  rule {
    id = "permanent-delete"
    status = "Enabled"

    noncurrent_version_expiration {
      newer_noncurrent_versions = "2"
      noncurrent_days = 2
    }
  }
}
