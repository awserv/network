data "aws_availability_zones" "available" {
  state = "available"
}

# как соединить 2 SUBNETS в ОДИН
resource "aws_subnet" "private_globin_0" {
  vpc_id     = aws_vpc.globin.id
  cidr_block = "10.0.1.0/28"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    name = "private_globin_0"
  }
}
# create subnet + AZ variable
resource "aws_subnet" "private_globin_1" {
  vpc_id     = aws_vpc.globin.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "10.0.2.0/28"
  
  tags = {
    name = "private_globin_1"
  }
}