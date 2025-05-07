variable "function_name" {
  type        = string
  description = "The name of the Lambda function."
}

variable "description" {
  type        = string
  description = "The description of the Lambda function."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function that you are uploading."
}

variable "timeout" {
  type        = number
  description = "The amount of time that Lambda allows a function to run before stopping it. (seconds)"
}

variable "memory_size" {
  type        = number
  description = "The amount of memory available to the function at runtime. (MB)"
}

variable "source_path" {
  type        = string
  description = "The path to the source code of the Lambda function."
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables that are accessible from function code during execution."
  default     = {}
}

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role that Lambda assumes when it executes your function."
}

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  description = "VPC configuration for the Lambda function."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the Lambda function."
  default     = {}
}

variable "log_retention_in_days" {
  type        = number
  description = "The number of days to retain logs for."
  default     = 14
}

variable "layers" {
  type        = list(string)
  description = "A list of Lambda Layer ARNs to attach to the function."
  default     = []
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "The number of concurrent executions reserved for the function."
  default     = -1
}
