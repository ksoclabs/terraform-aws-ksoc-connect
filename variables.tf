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

variable "eks_audit_logs_filter_pattern" {
  type        = string
  default     = "{ $.stage = \"ResponseComplete\" && $.requestURI != \"/version\" && $.requestURI != \"/version?*\" && $.requestURI != \"/metrics\" && $.requestURI != \"/metrics?*\" && $.requestURI != \"/logs\" && $.requestURI != \"/logs?*\" && $.requestURI != \"/swagger*\" && $.requestURI != \"/livez*\" && $.requestURI != \"/readyz*\" && $.requestURI != \"/healthz*\" }"
  description = "The Cloudwatch Log Subscription Filter pattern"
}

variable "eks_audit_logs_regions" {
  type        = list(string)
  default     = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
  description = "Regions from which Cloudwatch will be allowed to send logs to the Firehose"
}

variable "eks_audit_logs_multi_region" {
  type        = bool
  default     = false
  description = "Enable multi-region support for the EKS audit logs. This requires creating subscription filters in each region outside of this module. See documentation for more information."
}
