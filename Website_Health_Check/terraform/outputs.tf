output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "ec2_instance_id" {
  value = aws_instance.website.id
}

output "alb_dns_name" {
  value = aws_lb.website.dns_name
}

output "docker_image" {
  value = var.docker_image
}