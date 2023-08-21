variable "ksoc_assumed_role_arn" {
  type        = string
  description = "KSOC Role that will be allowed to assume"
  default     = "arn:aws:iam::955322216602:role/ksoc-connector"
}
