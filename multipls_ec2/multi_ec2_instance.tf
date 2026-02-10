# terraform provider
/*
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "0.0.0" # mention required version
        }
    }
}
*/

provider "aws" {
  region     = "us-east-1"
  access_key = "12345" # relpace with correct creds
  secret_key = "12345" # replace with correct creds
}

# multiple aws ec2 instance
resource "aws_instance" "my_ec2" {

 /* # ************ meta argument for count ************
        count = 3 # ---> it will create same name instance with below tag value.
        ami = "ami-0b6c6ebed2801a5cb" # (ubuntu ami) replace with correct ami
        instance_type = "t3.micro"
        user_data = file("${path.module}/script_nginx.sh") # ---> user data or any script
        
        # Specify root volume (Optional)
        root_block_device {
            volume_size = 15
            volume_type = "gp3"
        }
        tags = {
            Name = "multiple_ec2"
        }
    */

  # ************ meta argument for for_each ************
  for_each = tomap({
    "Prod_Server"  = "t2.micro",
    "Dev_Server"   = "t2.medium",
    "Stage_Server" = "t3.micro",
  })
  ami           = "ami-0b6c6ebed2801a5cb" # (ubuntu ami) replace with correct ami
  instance_type = each.value
  user_data     = file("${path.module}/script_nginx.sh") # ---> user data or any script

  # Specify root volume (Optional)
  root_block_device {
    volume_size = 15
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
  }
}