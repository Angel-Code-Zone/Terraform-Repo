
# AWS ec2 instance

resource "aws_instance" "my_ec2" {
  ami           = "ami-0b6c6ebed2801a5cb" # (ubuntu ami) replace with correct ami.
  instance_type = "t3.micro"
  key_name      = aws_key_pair.my_key_pair.key_name # ---> key_pair
  # security_groups = ["${aws_security_group.my_sg.id}"]
  vpc_security_group_ids = [aws_security_group.my_sg.id]          # ---> security_group
  user_data              = file("${path.module}/script_nginx.sh") # ---> user data or any script

  # Root Volume Section
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  # Tags Sections
  tags = {
    Name = "ec2_machine-tf"
  }

  /* ################################
  # Alternative way to provisioner file
  provisioner "file" {
    source      = "readme.md"      # terraform machine
    destination = "/tmp/readme.md" # remote machine

    # Connect to machine for linux (ssh) & windows (winvar)
    connection {
      type        = "ssh"                                     # for linux machine connection.
      user        = "ubuntu"                                  # new built machine user name.
      private_key = file("${path.module}/key_pair_login.pub") # replace with correct private_key name.
      host        = "${self.public_ip}"                            # new built machine public ip add.
    }
  } ################################ */

  /*
  # Connect to machine for linux (ssh) & windows (winvar)
  connection {
    type        = "ssh"                                     # for linux machine connection.
    user        = "ubuntu"                                  # new built machine user name.
    private_key = file("${path.module}/key_pair_login.pub") # replace with correct private_key name.
    host        = self.public_ip                            # new built machine public ip add.
  }

  # provisioner file, local-exec, remote-exec --> always use as a last option
  provisioner "file" {
    source      = "readme.md"      # terraform machine
    destination = "/tmp/readme.md" # remote machine
  }

  provisioner "file" {
    source      = "This is test of content provisioner" # terraform machine
    destination = "/tmp/content.md"                     # remote machine
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/mypublicip.txt"
  }

  provisioner "local-exec" {
    working_dir = "/tmp/"
    command     = "echo ${self.public_ip} > /mypublicip.txt"
  }

  provisioner "local-exec" {
    interpreter = [
      "/usr/bin/python3", "-c"
    ]
    command = "print('Hello world')"
  }

  provisioner "local-exec" {
    command = "env > env.txt"
    environment = {
      envname = "envvalue"
    }
  }

  provisioner "local-exec" {
    command = "echo 'at Create'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'at Create'"
  }

  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'Hello Rakesh' > /tmp/test.txt"
    ]
  }

  provisioner "remote-exec" {
    script = "./testscript.sh"
  }
  */
}
