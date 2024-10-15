data "aws_vpc" "vpc1" {
    filter {
        name = "tag:Name"
        values = ["vpc"]
    }  
}

data "aws_subnet" "pub_sub1" {
    filter {
      name = "tag:Name"
      values = [ "Pub_sub" ]
    }
}

data "aws_internet_gateway" "igw1" {
    filter {
      name = "tag:Name"
      values = ["igw"]
    } 
}

data "aws_route_table" "rtb1" {
    filter {
      name = "tag:Name"
      values = ["rtb"]
    }  
}

data "aws_security_group" "sg1" {
    filter {
      name = "tag:Name"
      values = ["sg"]
    } 
}

resource "aws_subnet" "pub_sub2" {
  vpc_id     = data.aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
  availability_zone  = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub_sub2"
  }
}

//resource "aws_internet_gateway" "igw2" {
  //vpc_id = data.aws_vpc.vpc1.id

  //tags = {
    //Name = "igw2"
  //}
//}

resource "aws_route_table" "rtb2" {
  vpc_id = data.aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw1.id
  }
  tags = {
    Name = "rtb2"
  }
}

resource "aws_route_table_association" "rtb_assoc2" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.rtb2.id
}