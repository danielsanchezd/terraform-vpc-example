## EC2 Instances
## Note: The keypair used for these instances was created through the UI for security purposes. The AMI is also hardcoded to keep consistency between existing and new instances.

resource "aws_instance" "external" {
  ami = "ami-09ead922c1dad67e4"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.external1.id}"
  key_name = "Default"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  tags = {
    Name = "External"
  }
}

resource "aws_instance" "internal" {
  ami = "ami-09ead922c1dad67e4"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.internal1.id}"
  key_name = "Default"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  tags = {
    Name = "Internal"
  }
}
