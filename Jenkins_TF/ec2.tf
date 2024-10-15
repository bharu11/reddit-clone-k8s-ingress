resource "aws_instance" "ec2" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name = data.aws_key_pair.ec2_key.key_name
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = "${file("install.sh")}"
  security_groups = [aws_security_group.sg.id]


  tags = {
    Name = "EC2-instance"
  }
}