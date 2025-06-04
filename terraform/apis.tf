module "get_diary_list" {
  source        = "./modules/lambda"
  function_name = "get_diary_list"
  handler       = "main.lambda_handler"
  runtime       = "python3.13"
  source_path   = "./src/get_diary_list"
  environment_variables = {
    DB_SECRETS = data.aws_secretsmanager_secret_version.rds_credentials.secret_string
  }
  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  layers = [aws_lambda_layer_version.mysql_connection.arn]
}

module "create_diary" {
  source        = "./modules/lambda"
  function_name = "create_diary"
  handler       = "main.lambda_handler"
  runtime       = "python3.13"
  source_path   = "./src/create_diary"
  environment_variables = {
    DB_SECRETS = data.aws_secretsmanager_secret_version.rds_credentials.secret_string
  }
  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  layers = [aws_lambda_layer_version.mysql_connection.arn]
}

module "get_diary" {
  source        = "./modules/lambda"
  function_name = "get_diary"
  handler       = "main.lambda_handler"
  runtime       = "python3.13"
  source_path   = "./src/get_diary"
  environment_variables = {
    DB_SECRETS = data.aws_secretsmanager_secret_version.rds_credentials.secret_string
  }
  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  layers = [aws_lambda_layer_version.mysql_connection.arn]
}

module "get_ai_feedback" {
  source        = "./modules/lambda"
  function_name = "get_ai_feedback"
  handler       = "main.lambda_handler"
  runtime       = "python3.13"
  source_path   = "./src/get_ai_feedback"
  environment_variables = {
    DB_SECRETS = data.aws_secretsmanager_secret_version.rds_credentials.secret_string
  }
  vpc_config = {
    subnet_ids         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  layers = [aws_lambda_layer_version.mysql_connection.arn]
}
