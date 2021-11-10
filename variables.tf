variable "ksoc_role_arn" {
  type        = string
  description = "AWS IAM Role ARN provided by KSOC for resource discovery"

  validation {
    condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:role/.+", var.ksoc_role_arn))
    error_message = "Must be a valid AWS IAM role ARN."
  }
}
