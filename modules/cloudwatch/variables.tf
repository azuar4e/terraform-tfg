variable "lambda_function_name" {
  description = "Lambda function name to monitor"
  type        = string
}

variable "rds_instance_id" {
  description = "RDS instance identifier to monitor"
  type        = string
}

variable "sqs_queue_name" {
  description = "SQS queue name to monitor"
  type        = string
}
