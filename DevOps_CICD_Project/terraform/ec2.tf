resource "aws_instance" "app_server" {

  ami = var.ami_id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  key_name = var.key_name

  vpc_security_group_ids = [ aws_security_group.app_sg.id ]

  associate_public_ip_address = true

  user_data = file("${path.module}/userdata.sh")

  tags = {

    Name = "Application-Server"

  }

}