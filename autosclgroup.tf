resource "aws_autoscaling_group" "auto" {
  launch_configuration = aws_launch_configuration.launch.id
  //availability_zones   = data.aws_availability_zones.available.names
  vpc_zone_identifier = aws_subnet.private_globin.*.id
  desired_capacity = 2
  health_check_type = "EC2"
  min_size = 2
  max_size = 2
}

data "aws_ami" "ubuntu" { # create instance по типу сам выбирает
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "launch" {
  name = "ubuntu_2" # название в AWS
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  user_data = file("user_data.sh")
  security_groups = [ aws_security_group.allow_http.id ]
   lifecycle {
     create_before_destroy = true
   }
  }

resource "aws_autoscaling_attachment" "autoA" {
  autoscaling_group_name = aws_autoscaling_group.auto.id
  alb_target_group_arn = aws_alb_target_group.targ.arn
  depends_on = [ aws_alb_target_group.targ ]
}
