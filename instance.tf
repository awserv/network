#resource "aws_ami" "serv" {
#    most_recent = true
#    ami = "ami-0cc0a36f626a4fdf5"
#    instance_type = "t2.micro"
#    vpc_security_group_ids = [aws_security_group.globinsg.id]
#    user_data = templatefile("user_data.sh.tpl") 
#  }