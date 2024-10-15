data "aws_ami" "ami"{
    most_recent = true
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    owners = ["amazon"]
}

data "aws_key_pair" "ec2_key" {
  key_name           = "berkley"
  include_public_key = true
}