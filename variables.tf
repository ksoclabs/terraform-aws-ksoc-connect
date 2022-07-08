variable "ksoc_role_arn" {
  type        = string
  description = "AWS IAM Role ARN provided by KSOC for connection"

  validation {
    condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.ksoc_role_arn))
    error_message = "Must be a valid AWS IAM role ARN."
  }
}

variable "company_id" {
  type = string
  description = "Company ID obtained from KSOC"
}

variable "cloudtrail_enabled" {
  type = bool
  description = "Enable KSOC Cloudtrail discovery"
  default = false
}
