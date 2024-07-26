provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "ec2-instance" {
  ami           = "ami-09d83d8d719da9808"
  instance_type = "t2.micro"
  tags = {
    Name = "File Provisioners Test"
  }

  // this file will be created locally.
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> ./output/private_ips.txt"
  }

}
