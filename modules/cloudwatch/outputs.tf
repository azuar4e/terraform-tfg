output "sns_topic_arn" {
  description = "ARN of SNS topic for alarms"
  value       = aws_sns_topic.alarms.arn
}
