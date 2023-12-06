## Fetch already existing cognito data
data "terraform_remote_state" "cognito" {
  backend = "s3"
  config = {
    bucket = "marathon-terraform-state-en1"
    key    = "global/example/terraform.tfstate"
    region = "eu-north-1"
  }
}

## Fetch already existing lambda data
data "terraform_remote_state" "lambda" {
  backend = "s3"
  config = {
    bucket = "marathon-terraform-state-en1"
    key    = "backend/lambda/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "aws_lambda_function" "connect" {
  function_name = "${var.name_prefix}-Connect-func"
}

data "aws_lambda_function" "disconnect" {
  function_name = "${var.name_prefix}-Disconnect-func"
}

data "aws_lambda_function" "read" {
  function_name = "${var.name_prefix}-ReadMessage-func"
}

data "aws_lambda_function" "send" {
  function_name = "${var.name_prefix}-SendMessage-func"
}

data "aws_lambda_function" "get_all_chats" {
  function_name = "${var.name_prefix}-GetAllChats-func"
}

data "aws_lambda_function" "get_messages" {
  function_name = "${var.name_prefix}-GetMessages-func"
}

data "aws_lambda_function" "unread_messages" {
  function_name = "${var.name_prefix}-GetUnreadMessages-func"
}
