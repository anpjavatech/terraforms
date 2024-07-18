provider "aws" {
  region     = "eu-west-3"
  access_key = "XXX"
  secret_key = "XX"
}

//terraform import aws_instance.test <instance id>
resource "aws_instance" "test" {

}
