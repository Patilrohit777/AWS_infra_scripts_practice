provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI (for us-east-1)
  instance_type = "t2.micro"
}
