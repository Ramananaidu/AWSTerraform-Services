provider "aws"{
    region = "ap-south-1"
}

# data "aws_instance" "project_instance" {
#   #ami           = "ami-079b5e5b3971bd10d"
#   #instance_type = "t2.micro"
#   ami            = var.ami_name
#   instance_type  = var.instance_type_name

# }
resource "aws_vpc" "mouritech_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Mouritech-VPC"
    #location="Hyderabad"
  }
}
resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.mouritech_vpc.id}"
  cidr_block = "10.0.1.0/24"
  

  tags = {
    Name = "Mouri-Tech-subnet"
  }
}