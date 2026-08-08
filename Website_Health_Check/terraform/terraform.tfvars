aws_region  = "us-east-1"
environment = "production"

vpc_cidr = "10.0.0.0/16"

public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"

private_subnet_cidr = "10.0.10.0/24"

availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

instance_type = "t2.micro"

docker_image = "rksingh2391998/website:latest"

s3_bucket_name = "terraform-state-rakesh-2026"