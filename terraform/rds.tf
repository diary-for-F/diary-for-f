# ✅ 실제 존재하는 Secrets 이름으로 수정
data "aws_secretsmanager_secret" "aurora_credentials" {
  name = "diary-for-f/db-credentials" # 🔄 수정: Secrets 이름 일치
}

data "aws_secretsmanager_secret_version" "aurora_credentials" {
  secret_id = data.aws_secretsmanager_secret.aurora_credentials.id
}

locals {
  # ✅ SecretsManager JSON 구조 기반 파싱
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
  # 🔄 수정: Secrets JSON에 없는 cluster_identifier → 문자열 하드코딩
  cluster_identifier = "diary-for-f-aurora-cluster"
  engine             = "aurora-mysql"
  engine_version     = "8.0.mysql_aurora.3.08.0"

  # ✅ 아래 값들은 Secrets에서 가져옴
  database_name   = local.db_credentials.dbname
  master_username = local.db_credentials.username
  master_password = local.db_credentials.password

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
  identifier          = local.db_credentials.dbInstanceIdentifier # ✅ 여기서는 Secrets 사용 가능
  instance_class      = "db.serverless"
  cluster_identifier  = aws_rds_cluster.aurora.id
  engine              = aws_rds_cluster.aurora.engine
  engine_version      = aws_rds_cluster.aurora.engine_version
  publicly_accessible = false
}
