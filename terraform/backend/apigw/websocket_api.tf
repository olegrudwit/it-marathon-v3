# API Gateway V2 (WebSocket)
resource "aws_apigatewayv2_api" "websocket_apigw" {
  name                       = "${var.name_prefix}-websocket"
  description                = "Websocket API GW for ${var.name_prefix}"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

resource "aws_apigatewayv2_stage" "websocket_apigw" {
  api_id        = aws_apigatewayv2_api.websocket_apigw.id
  name          = "dev"
  deployment_id = aws_apigatewayv2_deployment.websocket_apigw.id

  default_route_settings {
    data_trace_enabled     = true
    logging_level          = "INFO"
    throttling_burst_limit = 5000
    throttling_rate_limit  = 10000
  }
}

# Api integrations
resource "aws_apigatewayv2_integration" "websocket_apigw_connect" {
  api_id           = aws_apigatewayv2_api.websocket_apigw.id
  integration_type = "AWS_PROXY"

  credentials_arn      = aws_iam_role.invocation_role.arn
  integration_uri      = data.aws_lambda_function.connect.invoke_arn
  timeout_milliseconds = 29000
}

resource "aws_apigatewayv2_integration" "websocket_apigw_disconnect" {
  api_id           = aws_apigatewayv2_api.websocket_apigw.id
  integration_type = "AWS_PROXY"

  credentials_arn      = aws_iam_role.invocation_role.arn
  integration_uri      = data.aws_lambda_function.disconnect.invoke_arn
  timeout_milliseconds = 29000
}

resource "aws_apigatewayv2_integration" "websocket_apigw_read" {
  api_id           = aws_apigatewayv2_api.websocket_apigw.id
  integration_type = "AWS_PROXY"

  credentials_arn      = aws_iam_role.invocation_role.arn
  integration_uri      = data.aws_lambda_function.read.invoke_arn
  timeout_milliseconds = 29000
}

resource "aws_apigatewayv2_integration" "websocket_apigw_send" {
  api_id           = aws_apigatewayv2_api.websocket_apigw.id
  integration_type = "AWS_PROXY"

  credentials_arn      = aws_iam_role.invocation_role.arn
  integration_uri      = data.aws_lambda_function.send.invoke_arn
  timeout_milliseconds = 29000
}

# Api routes
resource "aws_apigatewayv2_route" "websocket_apigw_disconnect" {
  api_id    = aws_apigatewayv2_api.websocket_apigw.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.websocket_apigw_disconnect.id}"
}

resource "aws_apigatewayv2_route" "websocket_apigw_connect" {
  api_id    = aws_apigatewayv2_api.websocket_apigw.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.websocket_apigw_connect.id}"
}

resource "aws_apigatewayv2_route" "websocket_apigw_read" {
  api_id    = aws_apigatewayv2_api.websocket_apigw.id
  route_key = "read"
  target    = "integrations/${aws_apigatewayv2_integration.websocket_apigw_read.id}"
}

resource "aws_apigatewayv2_route" "websocket_apigw_send" {
  api_id    = aws_apigatewayv2_api.websocket_apigw.id
  route_key = "send"
  target    = "integrations/${aws_apigatewayv2_integration.websocket_apigw_send.id}"
}

# APi route response (Two way communications enable)
resource "aws_apigatewayv2_route_response" "websocket_apigw_connect" {
  api_id             = aws_apigatewayv2_api.websocket_apigw.id
  route_id           = aws_apigatewayv2_route.websocket_apigw_connect.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route_response" "websocket_apigw_disconnect" {
  api_id             = aws_apigatewayv2_api.websocket_apigw.id
  route_id           = aws_apigatewayv2_route.websocket_apigw_disconnect.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route_response" "websocket_apigw_read" {
  api_id             = aws_apigatewayv2_api.websocket_apigw.id
  route_id           = aws_apigatewayv2_route.websocket_apigw_read.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_route_response" "websocket_apigw_send" {
  api_id             = aws_apigatewayv2_api.websocket_apigw.id
  route_id           = aws_apigatewayv2_route.websocket_apigw_send.id
  route_response_key = "$default"
}

# Deploy stage
resource "aws_apigatewayv2_deployment" "websocket_apigw" {
  api_id      = aws_apigatewayv2_api.websocket_apigw.id
  description = "Websocket deployment for It marathone"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_apigatewayv2_route.websocket_apigw_connect,
    aws_apigatewayv2_route.websocket_apigw_disconnect,
    aws_apigatewayv2_route.websocket_apigw_read,
    aws_apigatewayv2_route.websocket_apigw_send
  ]
}
