resource "aws_iam_user" "dev_user" {
  name = "Developer"
  force_destroy = true
  tags = local.tags
}

resource "aws_iam_user_login_profile" "dev_user" {
  user    = aws_iam_user.dev_user.name
}

resource "aws_iam_access_key" "dev_user" {
  user = aws_iam_user.dev_user.name
}

resource "aws_iam_user_group_membership" "dev_group" {
  user = aws_iam_user.dev_user.name

  groups = [
    aws_iam_group.developers.name
  ]
}

resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_policy" "developer_policy" {
  name  = "developer-policy"
  group = aws_iam_group.developers.name
  policy = data.aws_iam_policy_document.user_access_document.json
}