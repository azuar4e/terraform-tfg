output "sns_topic_arn" {
  description = "ARN of SNS topic for alarms"
  value       = aws_sns_topic.alarms.arn
}

output "lambda_log_group" {
  description = "CloudWatch log group for Lambda"
  value       = aws_cloudwatch_log_group.lambda.name
}

output "eks_log_group" {
  description = "CloudWatch log group for EKS"
  value       = aws_cloudwatch_log_group.eks.name
}
