data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
# IAM policy
data "aws_iam_policy_document" "lambda_access_document" {
  # Dynamodb access
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]
    resources = ["*"]
  }
  # CW access
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }

}
# API gateway
data "aws_api_gateway_rest_api" "marathone" {
  name = "${var.name_prefix}-api-gateway"
}
# Cognito
data "aws_cognito_user_pools" "marathone" {
  name = "${var.name_prefix}"
}
## Archive
data "archive_file" "lambda_python_archive" {
  type        = "zip"
  source_dir  = "${path.module}/../../../python/cognito/lambda/confirmSignUp/"
  output_path = "${path.module}/lambda-authorather.zip"
}
