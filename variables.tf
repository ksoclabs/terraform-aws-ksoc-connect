variable "ksoc_assumed_role_arn" {
  type        = string
  description = "KSOC Role that will be allowed to assume"
  default     = "arn:aws:iam::955322216602:role/ksoc-connector"
}

variable "enable_eks_audit_logs_pipeline" {
  type        = bool
  description = "Enable EKS Audit Logs Pipeline (CloudWatch Logs -> FireHose -> S3)"
  default     = false
}

variable "ksoc_eks_audit_logs_assumed_role_arn" {
  type        = string
  description = "KSOC Role dedicated for EKS audit logs that will be allowed to assume"
  default     = "arn:aws:iam::955322216602:role/ksoc-api-audit-us-west-2"
}
