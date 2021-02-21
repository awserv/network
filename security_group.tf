resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.globin.id

  ingress {
    description = "HTTP to VPC"
    from_port   = 80 # http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443 # https
    to_port     = 443
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}