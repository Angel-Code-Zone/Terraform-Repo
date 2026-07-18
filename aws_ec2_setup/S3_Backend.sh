# Create bucket for Terraform state file
aws s3 mb s3://terraform-state-rakesh-2026 --region us-east-1

# Enable versioning for state history
aws s3api put-bucket-versioning \
  --bucket terraform-state-rakesh-2026 \
  --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption \
  --bucket terraform-state-rakesh-2026 \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'