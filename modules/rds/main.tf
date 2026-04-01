resource "aws_db_instance" "postgres" {
  identifier           = "postgres-db"
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "17"
  instance_class       = "db.t3.micro"
  username             = "dbadmin"
  password             = "tfg_password"
  parameter_group_name = "default.postgres17"
  skip_final_snapshot  = true
  publicly_accessible  = true
  storage_encrypted    = true

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
}

resource "aws_db_subnet_group" "default" {
  name        = "rds-subnet-group"
  description = "Subnet group for postgres RDS - private subnets"
  subnet_ids  = var.private_subnet_ids
}