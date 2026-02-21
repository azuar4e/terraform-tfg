resource "aws_sns_topic" "alarms" {
  name = "cloudwatch-alarms"
}

resource "aws_cloudwatch_metric_alarm" "lambda-errors" {
  alarm_name                = "lambda-errors-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = 120
  statistic                 = "Sum"
  threshold                 = 1
  alarm_description         = "This metric monitors lambda errors"
  alarm_actions             = [aws_sns_topic.alarms.arn]

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "rds-cpu" {
  alarm_name                = "rds-cpu-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors rds cpu utilization"
  alarm_actions             = [aws_sns_topic.alarms.arn]

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "sqs-queue-length" {
  alarm_name                = "sqs-queue-length-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors sqs queue length"
  alarm_actions             = [aws_sns_topic.alarms.arn]

  dimensions = {
    QueueName = var.sqs_queue_name
  }
}
