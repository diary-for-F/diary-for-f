resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "diary-for-f-vpc"
    Description = "VPC for diary-for-f"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name        = "diary-for-f-private-a"
    Description = "Private subnet A for diary-for-f"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name        = "diary-for-f-private-b"
    Description = "Private subnet B for diary-for-f"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "diary-for-f-public-a"
    Description = "Public subnet A for diary-for-f"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name        = "diary-for-f-public-b"
    Description = "Public subnet B for diary-for-f"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "diary-for-f-internet-gateway"
    Description = "Internet gateway for diary-for-f"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "diary-for-f-public-route-table"
    Description = "Public route table for diary-for-f"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpc_endpoint" "bedrock" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-2.bedrock"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  security_group_ids = [
    aws_security_group.vpce.id,
    aws_security_group.lambda_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "diary-for-f-bedrock-vpc-endpoint"
    Description = "VPC endpoint for Bedrock service"
  }
}

resource "aws_vpc_endpoint" "bedrock_runtime" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-2.bedrock-runtime"
  vpc_endpoint_type = "Interface"

  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  security_group_ids = [
    aws_security_group.vpce.id,
    aws_security_group.lambda_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name        = "diary-for-f-bedrock-bedrock-vpc-endpoint"
    Description = "VPC endpoint for Bedrock Bedrock service"
  }
}
