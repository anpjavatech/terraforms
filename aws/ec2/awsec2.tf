provider "aws" {
  region     = "eu-west-3"
  access_key = "XXXXX"
  secret_key = "XXXXXX"
}

resource "aws_instance" "my-first-aws-instance" {
  ami           = "ami-09d83d8d719da9808"
  instance_type = "t2.micro"

  tags = {
    Name = "My-EC2"
  }

}