provider "aws" {
  region     = "eu-west-3"
  access_key = var.accesskey
  secret_key = var.secretkey
}

// make sure host have access to aws (else do aws configure and set it up)
terraform {
  backend "s3" {
    bucket = "anpks-terraform-state"
    key    = "key/terraform.tfstate"
    region = "eu-west-3"
  }
}


resource "aws_instance" "ec2-instance" {
  ami                    = "ami-09d83d8d719da9808"
  instance_type          = "t2.micro"
  key_name               = "deployer-key"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "File Provisioners Test"
  }

  provisioner "file" {
    source      = "./test.txt"
    destination = "/home/ubuntu/test.txt"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/file.log"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../keys/ec2-key")
    host        = self.public_ip
    timeout     = "4m"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.pubkey
}

resource "aws_security_group" "sg" {
  egress = [{
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    description      = "egress configuration"
    protocol         = "-1"
  }]
  ingress = [{
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    description      = "ingress configuration"
  }]
}
