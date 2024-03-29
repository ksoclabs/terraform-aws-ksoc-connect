variable "ksoc_assumed_role_arn" {
  type        = string
  description = "KSOC Role that will assume the ksoc-connect IAM role you create to interact with resources in your account"
  default     = "arn:aws:iam::955322216602:role/ksoc-connector"
}

variable "enable_eks_audit_logs_pipeline" {
  type        = bool
  description = "Enable EKS Audit Logs Pipeline (CloudWatch Logs -> FireHose -> S3)"
  default     = false
}

variable "eks_audit_logs_bucket_versioning_enabled" {
  type        = bool
  description = "Enable versioning for the S3 bucket that will store EKS audit logs"
  default     = true
}

variable "ksoc_eks_audit_logs_assumed_role_arn" {
  type        = string
  description = "KSOC Role dedicated for EKS audit logs that will be allowed to assume"
  default     = "arn:aws:iam::955322216602:role/ksoc-data-pipeline"
}
