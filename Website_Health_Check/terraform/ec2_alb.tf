resource "aws_instance" "website" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = templatefile(
    "${path.module}/../scripts/user_data.sh",
    {
      docker_image    = var.docker_image
      docker_username = var.docker_username
      docker_token    = var.docker_token
      s3_bucket       = var.s3_bucket_name

      dockerfile_b64 = base64encode(
        file("${path.module}/../Dockerfile_Website/Dockerfile")
      )

      index_html_b64 = base64encode(
        file("${path.module}/../Dockerfile_Website/index.html")
      )

      server_health_script_b64 = base64encode(
        templatefile(
          "${path.module}/../scripts/server_health_check.sh",
          {
            s3_bucket = var.s3_bucket_name
          }
        )
      )

      web_health_script_b64 = base64encode(
        templatefile(
          "${path.module}/../scripts/web_health_check.sh",
          {
            s3_bucket = var.s3_bucket_name
          }
        )
      )
    }
  )

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "website-health-server"
  }
}