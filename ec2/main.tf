resource "aws_instance" "example" {
  ami           = "${var.ec2-instance}"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.ec2-instance-name}"
  }
}

