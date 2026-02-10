# key pair (login)

resource "aws_key_pair" "my_key_pair" {
  key_name   = "ec2_key_pair-tf"
  public_key = file("ec2_key_pair-tf.pub") # replace with correct key_pair file name --> Alternative way - public_key = "123456"
}

output "keyname" {
  value = aws_key_pair.my_key_pair.key_name
}