## Fetch already existing lambda data
data "terraform_remote_state" "lambda" {
  backend = "s3"
  config = {
    bucket = "marathon-terraform-state-en1"
    key    = "backend/lambda/terraform.tfstate"
    region = "eu-north-1"
  }
}