output "function_arn" {
  value       = aws_lambda_function.main.arn
  description = "The ARN of the Lambda function."
}

output "function_name" {
  value       = aws_lambda_function.main.function_name
  description = "The name of the Lambda function."
}

output "invoke_arn" {
  value       = aws_lambda_function.main.invoke_arn
  description = "The ARN that you can use to invoke the Lambda function."
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.lambda_log_group.name
  description = "The name of the CloudWatch log group for the Lambda function."
}
