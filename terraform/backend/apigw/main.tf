resource "aws_api_gateway_rest_api" "marathone" {
  name = "${var.name_prefix}-api-gateway"

  body = templatefile("${path.module}/template/it-marathon-v3-dev.json", {
    create_user         = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_create_user}/invocations"
    delete_user         = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_delete_user}/invocations"
    update_user         = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_update_user}/invocations"
    get_user_list       = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_user_list}/invocations"
    get_user            = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_user}/invocations"
    get_user_by_query   = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_user_by_query}/invocations"
    get_messages        = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_message}/invocations"
    get_unread_messages = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_unread_message}/invocations"
    get_all_chats       = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/${local.lambda_arn_get_all_chats}/invocations"
  })
}

## API GW deployment
resource "aws_api_gateway_deployment" "marathone" {
  rest_api_id = aws_api_gateway_rest_api.marathone.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.marathone.body))
  }
}

resource "aws_api_gateway_stage" "marathone" {
  stage_name    = "dev"
  deployment_id = aws_api_gateway_deployment.marathone.id
  rest_api_id   = aws_api_gateway_rest_api.marathone.id
}

resource "aws_api_gateway_authorizer" "demo" {
  name        = "${var.name_prefix}-authorizer-cognito"
  rest_api_id = aws_api_gateway_rest_api.marathone.id

  authorizer_credentials = aws_iam_role.invocation_role.arn

  type = "COGNITO_USER_POOLS"

  provider_arns = [data.terraform_remote_state.cognito.outputs.cognito_pool_user_arn]
}


