module "it_marathon_v3" {
  source   = "../../../tf-custom-module/lambda"
  for_each = { for k, v in local.lambda_config : k => v }

  function_name = "${var.name_prefix}-${each.value.name}-func"
  filename      = each.value.filename

  iam_policy = data.aws_iam_policy_document.lambda_access_document.json
  handler    = each.value.handler

  memory_size = each.value.memory_size

  timeout = each.value.timeout
  runtime = each.value.runtime

  environment_variables = {
      PARAM1            = "VALUE"
      JAVA_TOOL_OPTIONS = "-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
  }

  allowed_triggers = each.value.trigger

  tags = {
    created_by  = "terraform"
    application = "backend_java lambda"
  }
}

