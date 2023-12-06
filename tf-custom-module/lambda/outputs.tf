output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.this.function_name
}

output "lambda_function_id" {
  value = aws_lambda_function.this.id
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.this.name
}

output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}

output "iam_role_arn" {
  value = aws_iam_role.iam_for_lambda.arn
}

output "iam_role_name" {
  value = aws_iam_role.iam_for_lambda.name
}

output "iam_role_id" {
  value = aws_iam_role.iam_for_lambda.id
}
