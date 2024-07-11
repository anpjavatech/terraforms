provider "aws" {
  region     = "eu-west-3"
  access_key = "XXXXXX"
  secret_key = "XXXX"
}

resource "aws_instance" "my-first-aws-instance" {
  ami                         = "ami-09d83d8d719da9808"
  instance_type               = var.instanceType
  count                       = var.instanceCount
  associate_public_ip_address = var.enable_public_ip
  tags                        = var.project_environment

}

resource "aws_iam_user" "users" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}






//inline variables are listed below.

//string
variable "instanceType" {
  type        = string
  default     = "t2.micro"
  description = "Instance type of the resource."
}

//number
variable "instanceCount" {
  type        = number
  default     = 2
  description = "No:of instance need to create."
}

//boolean
variable "enable_public_ip" {
  type        = bool
  default     = true
  description = "Enable public IP for the new resource."
}

//list
variable "user_names" {
  type        = list(string)
  default     = ["Anoop@1987", "Manasa@1991", "Ishaan@2020"]
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
