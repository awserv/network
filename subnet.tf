data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "private_globin" {
    count = local.subnet_count
    vpc_id = aws_vpc.globin.id
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    cidr_block = element(local.subnet_cidr, count.index)
    tags = {
        Name = "private_globin_${count.index}"
    }
}