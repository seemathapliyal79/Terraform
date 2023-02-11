provider "aws" {
access_key = "<Your_Access_Key>"
secret_key = "<Your_Secret_Key>"
token = "<Your_Security_Token>"
region = "us-east-1"
}

resource "aws_instance" "terraform_demo" {
ami = "ami-09e67e426f25ce0d7"
instance_type = "t2.micro"
}
