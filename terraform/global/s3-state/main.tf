resource "aws_s3_bucket" "tf_state" {
  bucket = "marathon-terraform-state-${var.short_region}"

  tags = {
    Created_by = "terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.tf_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "marathon-terraform-state-${var.short_region}"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}