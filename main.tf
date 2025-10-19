provider "aws" {
  region = "us-east-2"
}

variable "server_port" {
    description = "The port on which the server will listen"
    type        = number
    default     = 8080
}

output "public_ip" {
    description = "the public IP of the web server"
    value       = aws_instance.example.public_ip
}

resource "aws_instance" "example" {
    ami           = "ami-0cfde0ea8edd312d4"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.JK-instance.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF

    user_data_replace_on_change = true

    tags = {
        Name = "Jozef_Test_terraform"
    }
}

resource "aws_security_group" "JK-instance" {
    name = "TF-example-instance"

    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}