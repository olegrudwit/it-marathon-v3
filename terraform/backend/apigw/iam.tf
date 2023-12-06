data "aws_iam_policy_document" "invocation_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "apigw_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "apigw_policy" {
  name   = "${var.name_prefix}-api-policy"
  policy = data.aws_iam_policy_document.apigw_policy_document.json
}

resource "aws_iam_role_policy_attachment" "apigw_policy_attachment" {
  policy_arn = aws_iam_policy.apigw_policy.arn
  role       = aws_iam_role.invocation_role.name
}

resource "aws_iam_role" "invocation_role" {
  name               = "it-marathon-v3-apigw-invocation-role"
  assume_role_policy = data.aws_iam_policy_document.invocation_assume_role.json
}