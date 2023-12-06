variable "function_name" {
  description = "Name of Function"
}

variable "filename" {
  description = "Path to zip or jar file"
}

variable "handler" {
  description = "Function handler"
}

variable "memory_size" {
  description = "Function memory size"
}

variable "timeout" {
  description = "Function time out"
}

variable "runtime" {
  description = "Function language"
}

variable "environment_variables" {
  description = "Function environment variables"
}

variable "allowed_triggers" {
  description = "Map of allowed triggers to create Lambda permissions."
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "Tags"
}

variable "retention_in_days" {
  description = "How long to keep logs"
  default     = 7
}

variable "iam_policy" {
  description = "Addition iam policy"
}

