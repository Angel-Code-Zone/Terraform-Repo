output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private.id
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.website.id
}

output "ec2_private_ip" {
  description = "Private IP of EC2"
  value       = aws_instance.website.private_ip
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = aws_lb.website.dns_name
}

output "website_url" {
  description = "Website URL"
  value       = "http://${aws_lb.website.dns_name}"
}

output "nat_gateway_public_ip" {
  description = "NAT Gateway public IP"
  value       = aws_eip.nat.public_ip
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = var.s3_bucket_name
}