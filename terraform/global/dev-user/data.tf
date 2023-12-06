data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "user_access_document" {
  # S3 access
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = ["*"]
  }
  # Dynamodb access
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:*",
    ]
    resources = [
      "*"
    ]
  }
  # Lambda access
  statement {
    effect = "Allow"
    actions = [
      "lambda:*",
    ]
    resources = [
      "*"
    ]
  }
  # Api Gateway
  statement {
    effect = "Allow"
    actions = [
      "apigateway:*",
    ]
    resources = [
      "*"
    ]
  }
  # Cognito
  statement {
    effect = "Allow"
    actions = [
      "cognito-idp:*",
      "cognito-sync:*",
      "cognito-identity:*",
    ]
    resources = [
      "*"
    ]
  }
  # Amplify
  statement {
    effect = "Allow"
    actions = [
      "amplify:*",
    ]
    resources = [
      "*"
    ]
  }
   # Iam
  statement {
    effect = "Allow"
    actions = [
      "iam:*",
    ]
    resources = [
      "*"
    ]
  }
   # CloudWatch
  statement {
    effect = "Allow"
    actions = [
      "logs:*",
      "cloudwatch:*",
    ]
    resources = [
      "*"
    ]
  }
}