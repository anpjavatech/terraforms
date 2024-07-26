provider "aws" {
  region = "eu-west-3"
}

module "webserver1" {
  source = "./module1"
  pubkey = var.pubkey
}
