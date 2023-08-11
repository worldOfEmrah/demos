provider "aws" {
  region = "${var.region}"
  version = "~> 2.46"
}
terraform {
  required_version = "0.11.14"
  required_providers {
    aws = "2.63.0"
    null = "2.1.2"
  }
}
