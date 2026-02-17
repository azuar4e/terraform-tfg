resource "aws_dynamodb_table" "jobs" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "N"
  }

  attribute {
    name = "SK"
    type = "N"
  }

  attribute {
    name = "status"
    type = "S"
  }

  global_secondary_index {
    name = "JobStatusIndex"
    key_schema {
      attribute_name = "PK"
      key_type       = "HASH"
    }

    key_schema {
      attribute_name = "status"
      key_type       = "RANGE"
    }
    projection_type = "ALL"
  }
}