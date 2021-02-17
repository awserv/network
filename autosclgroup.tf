resource "aws_autoscaling_group" "auto" {
  launch_configuration = aws_launch_configuration.launch.id
  availability_zones   = data.aws_availability_zones.available.names
  min_size = 1
  max_size = 2
}

resource "aws_launch_configuration" "launch" {
  name = "ubuntu_2"
  image_id        = "ami-07ebfd5b3428b6f4d"
  instance_type   = "t2.micro"
}

#связать инстанс с чсекурити груп и сделать два инстанса потом подложить файл datauser 
#а котором установим nginx написать route table автоскелинг груп посмотреть как соединить с vpc
