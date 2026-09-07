
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "../modules/s3"

  bucket_name = var.bucket_name
  environment = "prod"
}