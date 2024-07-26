provider "aws" {
  region = "eu-west-3"
}


resource "aws_instance" "ec2-instance" {
  ami                    = "ami-09d83d8d719da9808"
  instance_type          = "t2.micro"
  key_name               = "ec2-key"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "User Data Test"
  }

  user_data = file("bootstrap.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../keys/ec2-key")
    host        = self.public_ip
    timeout     = "4m"
  }
}

resource "aws_security_group" "sg" {
  name        = "EC2 Webserver SG"
  description = "Security group for Module 1 Webserver."
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
    },
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "ingress configuration"
  }]
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = var.pubkey
}
