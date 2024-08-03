locals {
  instance-type = {
    default : "t3.mico"
    dev : "t3.micro"
    prod : "t3.large"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "micro" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.instance-type[terraform.workspace]

  tags = {
    Name = "HelloWorld"
  }
}
