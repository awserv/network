resource "aws_security_group" "globinsg" {
  name      = "SecGroup"
  vpc_id = aws_vpc.globin.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "all"
    cidr_blocks     = ["0.0.0.0/0"]
   }

  tags = {
  Name = "globinsg"
  Owner = "globin"
  }
}