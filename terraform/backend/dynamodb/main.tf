resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "${var.name_prefix}-user-db"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "email"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "location"
    type = "S"
  }

  attribute {
    name = "birthday"
    type = "N"
  }

  attribute {
    name = "registration"
    type = "N"
  }

  attribute {
    name = "country"
    type = "S"
  }

  global_secondary_index {
    name               = "country-name-index"
    hash_key           = "country"
    range_key          = "name"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "country-birthday-index"
    hash_key           = "country"
    range_key          = "birthday"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "country-location-index"
    hash_key           = "country"
    range_key          = "location"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "country-registration-index"
    hash_key           = "country"
    range_key          = "registration"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }
}

resource "aws_dynamodb_table" "backend_dotnet" {
  name           = "${var.name_prefix}-message-db"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "sender_email"
    type = "S"
  }

  attribute {
    name = "receiver_email"
    type = "S"
  }

  attribute {
    name = "chat_id"
    type = "S"
  }

  attribute {
    name = "text"
    type = "S"
  }

  attribute {
    name = "message_date_time"
    type = "N"
  }

  attribute {
    name = "is_read"
    type = "B"
  }

  global_secondary_index {
    name               = "gsi_0"
    hash_key           = "chat_id"
    range_key          = "message_date_time"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "gsi_1"
    hash_key           = "chat_id"
    range_key          = "sender_email"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "gsi_2"
    hash_key           = "chat_id"
    range_key          = "receiver_email"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "gsi_3"
    hash_key           = "chat_id"
    range_key          = "text"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }

  global_secondary_index {
    name               = "gsi_4"
    hash_key           = "chat_id"
    range_key          = "is_read"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }
}

resource "aws_dynamodb_table" "backend_dotnet_connection" {
  name           = "${var.name_prefix}-user-conect-db"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "connectionId"

  attribute {
    name = "connectionId"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  global_secondary_index {
    name               = "userId-index"
    hash_key           = "userId"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "ALL"
  }
}

