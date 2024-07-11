provider "aws" {
  region     = "eu-west-3"
  access_key = var.accesskey
  secret_key = var.secretkey
}

locals {
  env = "dev"
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.env}"
  }

}

resource "aws_instance" "my-first-aws-instance" {
  ami                         = "ami-09d83d8d719da9808"
  instance_type               = var.instanceType
  count                       = var.instanceCount
  associate_public_ip_address = var.enable_public_ip
  tags                        = var.project_environment

}

// list using count
resource "aws_iam_user" "users" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

// set using for each (we cannot use list for for-each loop)
resource "aws_iam_user" "for-each-user" {
  for_each = var.for_each_user_names
  name     = each.value
}




//example : to show usage of inline variables.

//list
variable "user_names" {
  type        = list(string)
  default     = ["Anoop@1987", "Manasa@1991", "Ishaan@2020"]
  description = "IAM Users"
}

//set
variable "for_each_user_names" {
  type        = set(string)
  default     = ["Anoop", "Manasa", "Ishaan"]
  description = "IAM Users"
}

//map
variable "project_environment" {
  type        = map(string)
  description = "Project name and environment."
  default = {
    "project"     = "project-alpha",
    "environment" = "dev"
  }
}
