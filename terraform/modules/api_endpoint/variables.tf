variable "rest_api_id" {
  type        = string
  description = "The ID of the API Gateway REST API to which the Lambda function will be integrated."
}

variable "parent_resource_id" {
  type        = string
  description = "The ID of the parent resource in the API Gateway where the Lambda function will be integrated."
}

variable "rest_api_execution_arn" {
  type        = string
  description = "The execution ARN of the API Gateway REST API."
}
variable "path_part" {
  type        = string
  description = "The path part for the API Gateway resource where the Lambda function will be integrated."
}

variable "http_method" {
  type        = string
  description = "The HTTP method for the API Gateway method that will invoke the Lambda function. (e.g., GET, POST)"
}

variable "uri" {
  type        = string
  description = "The URI for the Lambda function integration in the API Gateway."
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function to be invoked by the API Gateway."
}
