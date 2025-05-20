module "calendar_view" {
  source                         = "./modules/lambda"
  function_name                  = "calendar_view"
  description                    = "Get diaries by date range"
  source_path                    = "${path.module}/src/calendar_view"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.11"
  timeout                        = 10
  memory_size                    = 128
  reserved_concurrent_executions = -1
  log_retention_days             = 14

  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  tags = {
    App = "feelim"
  }
}

module "create_diary" {
  source                         = "./modules/lambda"
  function_name                  = "create_diary"
  description                    = "Create diary with GPT"
  source_path                    = "${path.module}/src/create_diary"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.11"
  timeout                        = 20
  memory_size                    = 256
  reserved_concurrent_executions = -1
  log_retention_days             = 14

  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  tags = {
    App = "feelim"
  }
}

module "get_diary" {
  source                         = "./modules/lambda"
  function_name                  = "get_diary"
  description                    = "Get one diary by ID"
  source_path                    = "${path.module}/src/get_diary"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.11"
  timeout                        = 10
  memory_size                    = 128
  reserved_concurrent_executions = -1
  log_retention_days             = 14

  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  tags = {
    App = "feelim"
  }
}

module "list_diaries" {
  source                         = "./modules/lambda"
  function_name                  = "list_diaries"
  description                    = "List diaries paginated"
  source_path                    = "${path.module}/src/list_diaries"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.11"
  timeout                        = 10
  memory_size                    = 128
  reserved_concurrent_executions = -1
  log_retention_days             = 14

  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  tags = {
    App = "feelim"
  }
}
