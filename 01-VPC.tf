### VPC Main

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.test.id}"

  tags = {
    Name = "Main"
  }
}

### Subnets

resource "aws_subnet" "external1" {
  vpc_id     = "${aws_vpc.test.id}"
  availability_zone = "eu-west-2a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "External Subnet 1"
  }
}

resource "aws_subnet" "external2" {
  vpc_id     = "${aws_vpc.test.id}"

  availability_zone = "eu-west-2b"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "External Subnet 2"
  }
}

resource "aws_subnet" "internal1" {
  vpc_id     = "${aws_vpc.test.id}"
  availability_zone = "eu-west-2a"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "Internal Subnet"
  }
}

resource "aws_subnet" "internal2" {
  vpc_id     = "${aws_vpc.test.id}"
  availability_zone = "eu-west-2b"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "Internal Subnet"
  }
}

## Route tables

resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.test.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "External"
  }
}

resource "aws_route_table" "internal" {
  vpc_id = "${aws_vpc.test.id}"

  tags = {
    Name = "Internal"
  }
}

## Security Groups

resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id = "${aws_vpc.test.id}"

  tags = {
    Name = "Default SSH"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 
