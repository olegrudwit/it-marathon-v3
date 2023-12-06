module "billing_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = "prod"
  aws_account_id = data.aws_caller_identity.current.account_id
  monthly_billing_threshold = 1
  currency = "USD"

  sns_topic_arns = ["${aws_sns_topic.user_updates.arn}"]
}

resource "aws_sns_topic" "user_updates" {
  name = "billing-alert-${var.short_region}"
}

resource "aws_sns_topic_subscription" "user_updates_email_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "Mykhailo_Teliatnikov@epam.com"
}

data "aws_caller_identity" "current" {}
