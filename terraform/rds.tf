data "aws_secretsmanager_secret" "rds_credentials" {
  name = "diary-for-f/db-credentials"
}

data "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials.secret_string)
}

resource "aws_db_instance" "mysql" {
  identifier           = local.db_credentials.dbInstanceIdentifier
  allocated_storage    = 5 # 5GB
  storage_type         = "gp2"
  engine               = local.db_credentials.engine
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false
  db_name              = local.db_credentials.dbname
  username             = local.db_credentials.username
  password             = local.db_credentials.password

  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "diary-for-f-mysql-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name        = "diary-for-f-mysql-subnet-group"
    Description = "Subnet group for RDS MySQL instance"
  }
}
