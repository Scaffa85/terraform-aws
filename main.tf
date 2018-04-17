provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  count         = 0
  ami           = "ami-f4f21593"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!bin/bash
    echo "Hello World!" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

  tags {
    name = "Terraform WebServer"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress = {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
