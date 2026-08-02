variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "ami_id" {
  default = "ami-0f8a61b66d1accaee"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  type = string
}