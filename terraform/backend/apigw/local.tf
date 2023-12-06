locals {
  # java
  lambda_arn_create_user       = data.terraform_remote_state.lambda.outputs.lambda_arn["CreateUserFunction"]
  lambda_arn_delete_user       = data.terraform_remote_state.lambda.outputs.lambda_arn["DeleteUserFunction"]
  lambda_arn_update_user       = data.terraform_remote_state.lambda.outputs.lambda_arn["UpdateUserFunction"]
  lambda_arn_get_user_list     = data.terraform_remote_state.lambda.outputs.lambda_arn["GetUserListFunction"]
  lambda_arn_get_user          = data.terraform_remote_state.lambda.outputs.lambda_arn["GetUserFunction"]
  lambda_arn_get_user_by_query = data.terraform_remote_state.lambda.outputs.lambda_arn["GetUserListByQueryFunction"]
  # dotnet
  lambda_arn_get_message        = data.terraform_remote_state.lambda.outputs.lambda_arn["GetMessages"]
  lambda_arn_get_all_chats      = data.terraform_remote_state.lambda.outputs.lambda_arn["GetAllChats"]
  lambda_arn_get_unread_message = data.terraform_remote_state.lambda.outputs.lambda_arn["GetUnreadMessages"]
}
