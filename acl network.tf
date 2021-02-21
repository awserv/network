/*resource "aws_network_acl" "aclgroup" {
  vpc_id = aws_vpc.globin.id
  
  egress {
    protocol   = "tcp"
    rule_no    = 190
    action     = "allow"
    cidr_block = "10.0.0.0/24" 
    from_port  = 443
    to_port    = 443
  }
 egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.0.0/24" #egress only vpc adress
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" # with all ip adress
    from_port  = 80
    to_port    = 80
  }
    tags = {
      Name = "aclgr"
    }
   }*/