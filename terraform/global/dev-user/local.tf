locals {
  credentials = {
    User_name = aws_iam_user.dev_user.name
    Password  = aws_iam_user_login_profile.dev_user.password
    access_key = aws_iam_access_key.dev_user.id
    secret_key = aws_iam_access_key.dev_user.secret
    account_id = data.aws_caller_identity.current.account_id
  }


  tags = {
    created_by  = "terraform"
    application = "dev-user"
  }
}
