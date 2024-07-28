provider "aws" {
  region = "eu-north-1"
}

resource "aws_iam_user" "iam-users" {
  name  = "iam_user.${count.index}"
  count = 3
}

output "arn" {
  value = aws_iam_user.iam-users[*].arn
}

output "name" {
  value = aws_iam_user.iam-users[*].name
}

output "zipmap" {
  value = zipmap(aws_iam_user.iam-users[*].name, aws_iam_user.iam-users[*].arn)
}
