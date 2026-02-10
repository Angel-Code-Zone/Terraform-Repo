# Security group
resource "aws_security_group" "my_sg" {
  name        = "ec2_sg-tf"
  description = "this is ec2 instance security group using terraform"

  /*
  # dynamic way --> inbound rules
  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH port open"
    }
  }
  */

  # Directe way --> inbound rules (ingress)
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
    description = "Unencrypted data port"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Encrypted data port"
  }

  # outbound rules (egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "From anywhere"
  }

  # tags section
  tags = {
    Name = "my_security_group-tf"
  }
}

output "securitygroupdetails" {
  value = aws_security_group.my_sg.id
}