resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = var.filename

  role    = aws_iam_role.iam_for_lambda.arn
  handler = var.handler

  memory_size = var.memory_size

  timeout = var.timeout
  runtime = var.runtime

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_lambda_permission" "this" {
  for_each = var.allowed_triggers

  statement_id  = each.value.statement_id
  action        = each.value.action
  function_name = aws_lambda_function.this.function_name
  principal     = each.value.principal
  source_arn    = each.value.source_arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.retention_in_days

  tags = var.tags
}
