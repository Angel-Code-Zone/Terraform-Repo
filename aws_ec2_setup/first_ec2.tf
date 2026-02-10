# Terraform provider

provider "aws" {
  region     = "us-east-1"
  access_key = "12345" # relpace with correct creds
  secret_key = "12345" # replace with correct creds
}

# Key pair (Login)
resource "aws_key_pair" "my_key" {
  key_name   = "ec2-key-pair-tf"
  public_key = file("ec2_key_pair-tf.pub") # Replace the correct key pair file name.
}

# VPC and Security Group
resource "aws_default_vpc" "default" {

}
resource "aws_security_group" "my_security_group" {
  name        = "ec2_sg"
  description = "this will add TF generated security group"
  vpc_id      = aws_default_vpc.default.id # interpolation

  # inbound rules (ingress)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH port open"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP port open"
  }

  # outbound rules (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }
  # tags
  tags = {
    Name = "ec2_security_group"
  }
}

# aws ec2 instance
resource "aws_instance" "linux" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = "t2.micro"
  ami             = "ami-0b6c6ebed2801a5cb" # (ubuntu ami) replace with correct ami
  # user_data = file("abc.sh")

  # adding root block device
  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }

  # tags
  tags = {
    Name = "Terraform_ec2"
  }
}