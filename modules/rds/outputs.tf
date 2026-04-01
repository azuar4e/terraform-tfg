output "endpoint" {
  value = aws_db_instance.postgres.address
}

output "db_name" {
  value = aws_db_instance.postgres.db_name
}

output "instance_id" {
  value = aws_db_instance.postgres.identifier
}
