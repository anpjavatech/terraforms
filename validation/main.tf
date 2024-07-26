provider "aws" {
  region = "eu-west-3"
}


resource "aws_instance" "ec2-instance" {
  ami           = "ami-09d83d8d719da9808"
  instance_type = var.instanceType
  tags = {
    Name = "Validation Test"
  }
}
