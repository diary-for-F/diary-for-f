variable "function_name" {
  type        = string
  description = "Lambda Function Name"
}

variable "description" {
  type        = string
  description = "Lambda Function Description"
  default     = ""
}

variable "handler" {
  type        = string
  description = "Lambda Handler Function (e.g., index.handler)"
}

variable "runtime" {
  type        = string
  description = "Lambda Runtime Environment"
  default     = "nodejs16.x"
}

variable "timeout" {
  type        = number
  description = "Lambda Function Timeout (seconds)"
  default     = 30
}

variable "memory_size" {
  type        = number
  description = "Lambda Function Memory Size (MB)"
  default     = 128
}

variable "source_path" {
  type        = string
  description = "Lambda Function Source Path (ZIP file or directory)"
}

variable "environment_variables" {
  type        = map(string)
  description = "Lambda Function Environment Variables"
  default     = {}
}

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  description = "VPC Configuration for the Lambda function"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the Lambda function."
  default     = {}
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs in CloudWatch"
  default     = 14
}

variable "layers" {
  type        = list(string)
  description = "List of Lambda Layer ARNs to attach to the function"
  default     = []
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "The number of concurrent executions reserved for the function."
  default     = -1
}

variable "policy_statements" {
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  description = <<-EOT
    List of policy statements to attach to the Lambda function's execution role.
    Each statement should include the effect (Allow/Deny), actions, and resources.
    Example:
    [
      {
        effect    = "Allow"
        actions   = ["s3:GetObject"]
        resources = ["arn:aws:s3:::example-bucket/*"]
      }
    ]
    This will create an inline policy for the Lambda function's execution role.
  EOT
  default     = []
}

variable "managed_policy_arns" {
  type        = list(string)
  description = <<-EOT
    List of managed policy ARNs to attach to the Lambda function's execution role.
    Example:
    [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
    ]
    This will attach the specified managed policies to the Lambda function's execution role.
  EOT
  default     = []
}
