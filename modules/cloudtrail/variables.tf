variable "company_id" {
  type        = string
  description = "Company ID obtained from KSOC"
}

variable "lambda_debug" {
  type        = bool
  default     = false
  description = "More verbose logging in ksoc-observer Lambda"
}

variable "lambda_timeout" {
  type        = string
  default     = "30s"
  description = "HTTP timeout for ksoc-observer Lambda"
}

variable "ingest_url" {
  type        = string
  description = "URL of KSOC API"
}

variable "resources_prefix" {
  type        = string
  default     = "ksoc-discovery"
  description = "All resources created by this module will begin with this name"
}
