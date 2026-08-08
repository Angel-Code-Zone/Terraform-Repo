provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "Website-Health-Check"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}