resource "aws_cognito_user_pool" "marathon" {
  name = "${var.name_prefix}"

  auto_verified_attributes = ["email"]

  alias_attributes = ["email", "preferred_username", "phone_number"]

  schema {
    name = "email"
    attribute_data_type = "String"

    required = true
  }

  username_configuration {
    case_sensitive = false
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }

  lambda_config {
    pre_sign_up = data.terraform_remote_state.lambda.outputs.lambda_arn["AuthoritherFunction"]
  }
}


resource "aws_cognito_user_pool_client" "marathon" {
  name = "${var.name_prefix}"

  user_pool_id = aws_cognito_user_pool.marathon.id

  explicit_auth_flows = [ "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  id_token_validity = 60
  refresh_token_validity = 30
  access_token_validity = 60
  auth_session_validity = 3

  token_validity_units {
    access_token = "minutes"
    id_token = "minutes"
    refresh_token = "days"
  }
}