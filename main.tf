
terraform {
  required_providers {
    ksoc = {
      source = "ksoclabs/ksoc"
      version = "0.0.1"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "ksoc" {}

locals {
  ksoc_assumed_role_arn = "arn:aws:iam::652031173150:role/ksoc-connector"
}


resource "ksoc_aws_register" "this" {
  ksoc_api_url  = "https://api.sbx.ksoc.com"
  ksoc_assumed_role_arn = local.ksoc_assumed_role_arn
  access_key_id = var.access_key_id
  secret_key = var.secret_key
  ksoc_account_id = var.ksoc_account_id
  aws_account_id = data.aws_caller_identity.current.account_id
}
