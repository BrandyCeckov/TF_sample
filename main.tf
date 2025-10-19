provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "jozef_test" {
    ami           = "ami-0199d4b5b8b4fde0e"
    instance_type = "t3.micro"

    tags = {
        Name = "Jozef_Test_terraform"
    }
}