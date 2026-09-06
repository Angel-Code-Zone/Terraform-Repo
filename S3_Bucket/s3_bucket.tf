# AWS S3 bucket instance

resource "aws_s3_bucket" "my_bucket" {
  bucket = "rakesh2027"

  tags = {
    Name        = "rakesh_s3_terraform"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "rakesh98922"

  tags = {
    Name        = "rakesh_s3_bucket"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}