provider "aws" {
  region     = "eu-west-3"
  access_key = var.accesskey
  secret_key = var.secretkey
}

locals {
  ingress_rules = [{
    port        = 443
    description = "Ingres rule port for secured connection"
    },
    {
      port        = 22
      description = "Ingres rule port for tcp connection"
  }]
}

resource "aws_instance" "ec2-instance" {
  ami                    = "ami-09d83d8d719da9808"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "Module Test"
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

  // dynamic block which woud help us to remove duplication of configuration data.
  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = ingress.value.description
    }
  }
}
