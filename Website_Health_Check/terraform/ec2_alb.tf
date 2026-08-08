# =========================================================
# Ubuntu AMI
# =========================================================

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["0997201094779"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# =========================================================
# EC2 INSTANCE
# =========================================================

resource "aws_instance" "website" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  user_data = templatefile(
    "${path.module}/../scripts/user_data.sh",
    {
      docker_image             = var.docker_image
      docker_username          = var.docker_username
      docker_token             = var.docker_token
      s3_bucket                = var.s3_bucket_name
      dockerfile_b64           = filebase64("${path.module}/../Dockerfile_Website/Dockerfile")
      index_html_b64           = filebase64("${path.module}/../Dockerfile_Website/index.html")
      server_health_script_b64 = filebase64("${path.module}/../scripts/server_health_check.sh")
      web_health_script_b64    = filebase64("${path.module}/../scripts/web_health_check.sh")
    }
  )

  user_data_replace_on_change = true

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "website-health-server"
  }
}


# =========================================================
# APPLICATION LOAD BALANCER
# =========================================================

resource "aws_lb" "website" {
  name               = "website-health-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "website-health-alb"
  }
}


# =========================================================
# TARGET GROUP
# =========================================================

resource "aws_lb_target_group" "website" {
  name     = "website-health-tg"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  target_type = "instance"

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "80"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
    matcher             = "200-399"
  }

  tags = {
    Name = "website-health-target-group"
  }
}


# =========================================================
# REGISTER EC2 WITH TARGET GROUP
# =========================================================

resource "aws_lb_target_group_attachment" "website" {
  target_group_arn = aws_lb_target_group.website.arn

  target_id = aws_instance.website.id

  port = 80
}


# =========================================================
# ALB LISTENER
# =========================================================

resource "aws_lb_listener" "website" {
  load_balancer_arn = aws_lb.website.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.website.arn
  }
}