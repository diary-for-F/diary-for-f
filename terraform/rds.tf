data "aws_secretsmanager_secret" "aurora_credentials" {
  name = "diary-for-f/aurora-credentials"
}

data "aws_secretsmanager_secret_version" "aurora_credentials" {
  secret_id = data.aws_secretsmanager_secret.aurora_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.aurora_credentials.secret_string)
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "diary-for-f-aurora-subnet-group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name        = "diary-for-f-aurora-subnet-group"
    Description = "Subnet group for Aurora RDS"
  }
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier     = local.db_credentials.dbClusterIdentifier
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.08.0"
  database_name          = "diary_for_f"
  master_username        = local.db_credentials.username
  master_password        = local.db_credentials.password
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true

  serverlessv2_scaling_configuration {
    max_capacity             = 1.0
    min_capacity             = 0.0
    seconds_until_auto_pause = 3600
  }
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  identifier          = "diary-for-f-aurora-instance"
  instance_class      = "db.serverless" # Use serverless instance class
  cluster_identifier  = aws_rds_cluster.aurora.id
  engine              = aws_rds_cluster.aurora.engine
  engine_version      = aws_rds_cluster.aurora.engine_version
  publicly_accessible = false
}
