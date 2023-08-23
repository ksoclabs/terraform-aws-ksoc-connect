terraform {
  required_providers {
    ksoc = {
      source  = "ksoclabs/ksoc"
      version = "0.0.4"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "ksoc" {
  access_key_id = var.ksoc_access_key_id
  secret_key    = var.ksoc_secret_key
}

module "ksoc-connect" {
  # https://registry.terraform.io/modules/ksoclabs/ksoc-connect/aws/latest
  source  = "ksoclabs/ksoc-connect/aws"
  version = "<version>"
}
