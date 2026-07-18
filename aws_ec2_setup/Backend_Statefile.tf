terraform {
  backend "s3" {
    bucket       = "terraform-state-rakesh-2026" # Replace with your S3 bucket name
    key          = "aws_ec2_setup/main/terraform.tfstate"
    region       = "us-east-1" # Replace with your region
    use_lockfile = true        # S3 Native Locking (No DynamoDB needed)
    encrypt      = true
  }
}