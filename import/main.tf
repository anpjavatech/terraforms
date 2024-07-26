provider "aws" {
  region = "eu-west-3"
}

//terraform import aws_instance.test <instance id>
resource "aws_instance" "test" {

}
