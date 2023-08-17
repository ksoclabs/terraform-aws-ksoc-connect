terraform {
  required_providers {
    ksoc = {
      source  = "ksoclabs/ksoc"
      version = "0.0.1"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "ksoc" {}

module "ksoc-connect" {
  # https://registry.terraform.io/modules/ksoclabs/ksoc-connect/aws/latest
  source  = "ksoclabs/ksoc-connect/aws"
  version = "<version>"

  ksoc_access_key_id = var.ksoc_access_key_id
  ksoc_account_id    = var.ksoc_account_id
  ksoc_secret_key    = var.ksoc_secret_key
}
