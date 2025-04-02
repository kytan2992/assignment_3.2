provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ky-s3-terraform"
    key    = "ky-terraform-asg3-2.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_caller_identity" "current_user" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current_user.arn)[1]
  account_id  = data.aws_caller_identity.current_user.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}