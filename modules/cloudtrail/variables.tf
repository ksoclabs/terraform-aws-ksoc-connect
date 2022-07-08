variable "company_id" {
  type = string
}

variable "lambda_debug" {
  type    = bool
  default = false
}

variable "lambda_timeout" {
  type    = string
  default = "30s"
}

variable "ingest_url" {
  type    = string
  default = "https://api.ksoc.com"
}
