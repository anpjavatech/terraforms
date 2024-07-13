terraform {
  required_version = "1.9.1"
}

resource "aws_instance" "ec2-instance" {
  ami                    = "ami-09d83d8d719da9808"
  instance_type          = "t2.micro"
  key_name               = "ec2-key"
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "Module Test"
  }

  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this is module1 </h1></body></html>" > /var/www/html/index.html
      EOF
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
