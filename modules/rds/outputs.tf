output "endpoint" {
  value = aws_db_instance.postgres.address
}

output "db_name" {
  value = aws_db_instance.postgres.db_name
}

output "instance_id" {
  value = aws_db_instance.postgres.identifier
}

output "secret_arn" {
  value = aws_db_instance.postgres.master_user_secret[0].secret_arn
}
