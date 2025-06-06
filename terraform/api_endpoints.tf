resource "aws_api_gateway_rest_api" "diary_api" {
  name        = "diary-for-f-api"
  description = "API Gateway for Diary for F application"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

module "get_diary_list_endpoint" {
  source                 = "./modules/api_endpoint/"
  rest_api_id            = aws_api_gateway_rest_api.diary_api.id
  rest_api_execution_arn = aws_api_gateway_rest_api.diary_api.execution_arn
  parent_resource_id     = aws_api_gateway_rest_api.diary_api.root_resource_id
  path_part              = "diaries"
  http_method            = "GET"
  uri                    = module.get_diary_list.invoke_arn
  lambda_function_name   = module.get_diary_list.function_name
}

module "create_diary_endpoint" {
  source                 = "./modules/api_endpoint/"
  rest_api_id            = aws_api_gateway_rest_api.diary_api.id
  rest_api_execution_arn = aws_api_gateway_rest_api.diary_api.execution_arn
  parent_resource_id     = aws_api_gateway_rest_api.diary_api.root_resource_id
  path_part              = "diary"
  http_method            = "POST"
  uri                    = module.create_diary.invoke_arn
  lambda_function_name   = module.create_diary.function_name
}

module "get_diary_endpoint" {
  source                 = "./modules/api_endpoint/"
  rest_api_id            = aws_api_gateway_rest_api.diary_api.id
  rest_api_execution_arn = aws_api_gateway_rest_api.diary_api.execution_arn
  parent_resource_id     = aws_api_gateway_rest_api.diary_api.root_resource_id
  path_part              = "diary"
  http_method            = "GET"
  uri                    = module.get_diary.invoke_arn
  lambda_function_name   = module.get_diary.function_name
}

module "get_ai_feedback_endpoint" {
  source                 = "./modules/api_endpoint/"
  rest_api_id            = aws_api_gateway_rest_api.diary_api.id
  rest_api_execution_arn = aws_api_gateway_rest_api.diary_api.execution_arn
  parent_resource_id     = aws_api_gateway_rest_api.diary_api.root_resource_id
  path_part              = "ai-feedback"
  http_method            = "GET"
  uri                    = module.get_ai_feedback.invoke_arn
  lambda_function_name   = module.get_ai_feedback.function_name
}

resource "aws_api_gateway_deployment" "diary_api" {
  rest_api_id = aws_api_gateway_rest_api.diary_api.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    module.get_diary_list_endpoint,
    module.create_diary_endpoint,
    module.get_diary_endpoint,
    module.get_ai_feedback_endpoint,
    module.test_lambda_endpoint,
  ]
}

resource "aws_api_gateway_stage" "diary_api_stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.diary_api.id
  deployment_id = aws_api_gateway_deployment.diary_api.id

  description = "Production stage for Diary for F API"

  tags = {
    Name        = "diary-for-f-api-stage"
    Description = "Production stage for Diary for F API"
  }
}
