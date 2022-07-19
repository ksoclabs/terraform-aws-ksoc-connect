variable "ksoc_role_arn" {
  type        = string
  description = "AWS IAM Role ARN provided by KSOC for connection"

  validation {
    condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.ksoc_role_arn))
    error_message = "Must be a valid AWS IAM role ARN."
  }
}

variable "company_id" {
  type        = string
  description = "Company ID obtained from KSOC"
}

variable "cloudtrail_enabled" {
  type        = bool
  description = "Enable KSOC Cloudtrail discovery"
  default     = false
}

variable "ingest_url" {
  type        = string
  description = "URL of KSOC API"
}

variable "cloudtrail_lambda_debug" {
  type        = bool
  default     = false
  description = "More verbose logging in ksoc-connect-cloudtrail Lambda"
}

variable "cloudtrail_lambda_timeout" {
  type        = string
  default     = "30s"
  description = "HTTP timeout for ksoc-connect-cloudtrail Lambda"
}
