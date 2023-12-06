locals {
  backend_java_lambda_jar = "../../../upamers-java-backend/jars/DynamoDBApp-1.0.jar"

  lambda_config = {
    GetUserListFunction = {
      name        = "GetUserListFunction"
      handler     = "handler.GetUserListFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    CreateUserFunction = {
      name        = "CreateUserFunction"
      handler     = "handler.CreateUserFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    UpdateUserFunction = {
      name        = "UpdateUserFunction"
      handler     = "handler.UpdateUserFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    DeleteUserFunction = {
      name        = "DeleteUserFunction"
      handler     = "handler.DeleteUserFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    GetUserFunction = {
      name        = "GetUserFunction"
      handler     = "handler.GetUserFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    GetUserListByQueryFunction = {
      name        = "GetUserListByQueryFunction"
      handler     = "handler.GetUserListByQueryFunction::handleRequest"
      filename    = local.backend_java_lambda_jar
      memory_size = 512
      timeout     = 20
      runtime     = "java11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    AuthoritherFunction = {
      name        = "AuthoritherFunction"
      handler     = "lambda_function.lambda_handler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 128
      timeout     = 5
      runtime     = "python3.11"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
        cognito = {
          statement_id = "${var.name_prefix}-cognito-permission"
          action       = "lambda:InvokeFunction"
          principal    = "cognito-idp.amazonaws.com"
          source_arn = "${tolist(data.aws_cognito_user_pools.marathone.arns)[0]}"
        }
      }
    }
    Connect = {
      name        = "Connect"
      handler     = "OnConnect::OnConnect.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    Disconnect = {
      name        = "Disconnect"
      handler     = "OnDisconnect::OnDisconnect.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    ReadMessage = {
      name        = "ReadMessage"
      handler     = "ReadMessage::ReadMessage.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    SendMessage = {
      name        = "SendMessage"
      handler     = "SendMessage::SendMessage.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn   = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    GetAllChats = {
      name        = "GetAllChats"
      handler     = "GetAllChats::GetAllChats.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn   = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    GetMessages = {
      name        = "GetMessages"
      handler     = "GetMessages::GetMessages.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn   = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
    GetUnreadMessages = {
      name        = "GetUnreadMessages"
      handler     = "GetUnreadMessages::GetUnreadMessages.Function::FunctionHandler"
      filename    = data.archive_file.lambda_python_archive.output_path
      memory_size = 256
      timeout     = 100
      runtime     = "dotnet6"

      trigger = {
        api_gateway = {
          statement_id = "${var.name_prefix}-API-gateway-websocket-permission"
          action       = "lambda:InvokeFunction"
          principal    = "apigateway.amazonaws.com"
          source_arn   = "${data.aws_api_gateway_rest_api.marathone.execution_arn}/*"
        }
      }
    }
  }
}
