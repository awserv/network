# aplication load balancer
resource "aws_lb" "alb" {
 name =  "albin"
 internal = false
 idle_timeout = "100"
 load_balancer_type = "application"
 //vpc_id = aws_vpc.globin.id
 //count = local.subnet_count
 subnets = aws_subnet.private_globin.*.id
 security_groups = [ aws_security_group.allow_http.id ]
 //aws_network_acl = [aws_network_acl.aclgr.id]
 enable_deletion_protection = false # защита удаления
 depends_on = [aws_internet_gateway.gw]
}




resource "aws_alb_target_group" "targ" {
  name     = "tf-example-lb-tg"
  port     = 80
  target_type = "instance"
  protocol = "HTTP"
  vpc_id   = aws_vpc.globin.id
}

resource "aws_lb_listener" "lblist" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.targ.arn
  }
}



//resource "aws_alb_listener" "atlassian" {}