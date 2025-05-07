resource "aws_security_group" "rds_sg" {
  name        = "diary-for-f-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = []
    description     = "Allow MySQL access from the application server"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "diary-for-f-rds-sg"
    Description = "Security group for RDS instance"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "diary-for-f-lambda-sg"
  description = "Security group for Lambda function"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "diary-for-f-lambda-sg"
    Description = "Security group for Lambda function"
  }
}
