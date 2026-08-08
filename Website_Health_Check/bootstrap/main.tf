terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# S3 bucket for Terraform state and health-check logs
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-rakesh-2026"

  tags = {
    Name        = "terraform-state-rakesh-2026"
    Environment = "production"
    Purpose     = "Terraform State and Health Logs"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Terraform state object
resource "aws_s3_object" "terraform_state_folder" {
  bucket  = aws_s3_bucket.terraform_state.id
  key     = "terraform-state/"
  content = ""
}

# Server health log folder
resource "aws_s3_object" "server_health_folder" {
  bucket  = aws_s3_bucket.terraform_state.id
  key     = "logs/server-health/"
  content = ""
}

# Website health log folder
resource "aws_s3_object" "website_health_folder" {
  bucket  = aws_s3_bucket.terraform_state.id
  key     = "logs/website-health/"
  content = ""
}

output "bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}