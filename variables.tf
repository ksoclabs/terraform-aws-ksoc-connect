variable "ksoc_access_key_id" {
  type        = string
  description = "Ksoc API key"
}

variable "ksoc_account_id" {
  type        = string
  description = "Ksoc Account Identifier"
}

variable "ksoc_secret_key" {
  type        = string
  description = "Ksoc API secret"
}

variable "ksoc_assumed_role_arn" {
  type        = string
  description = "KSOC Role that will be allowed to assume"
  default     = "arn:aws:iam::955322216602:role/ksoc-connector"
}

variable "ksoc_api_url" {
  type        = string
  description = "KSOC API to use when registering an account"
  default     = "https://api.ksoc.com"
}
