provider "aws" {
  region     = "eu-west-3"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-09d83d8d719da9808"
  instance_type = "t2.micro"
  tags = {
    Name = "Datasource Test"
  }
}

data "aws_instance" "awsinstance" {

  filter {
    name   = "tag:Name"
    values = ["Datasource Test"]
  }
  depends_on = [aws_instance.ec2-instance]
}

output "myinstanceip" {
  value = data.aws_instance.awsinstance.public_ip
}
