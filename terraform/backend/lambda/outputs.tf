output "lambda_arn" {
  value = tomap({
    for k, v in module.it_marathon_v3 : k => v.lambda_function_arn
  })
}
