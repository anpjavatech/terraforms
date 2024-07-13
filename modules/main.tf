provider "aws" {
  region     = "eu-west-3"
  access_key = var.accesskey
  secret_key = var.secretkey
}

module "webserver1" {
  source = "./module1"
  pubkey = var.pubkey
}
