terraform {
  backend "s3" {
    bucket         = "marathon-terraform-state-en1"
    key            = "frontend/s3/terraform.tfstate" #"global/example/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "marathon-terraform-state-en1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}
