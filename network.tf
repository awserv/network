# create vpc network
provider "aws" {}
  #access_key = .......
  #secret_key = .......
  #region = eu-central


# create vpc
resource "aws_vpc" "globin" {
 cidr_block = "10.0.0.0/16" # 4 create subnet
 enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.globin.id

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "pubip" {
   vpc = true
   count = local.subnet_count
}

resource "aws_nat_gateway" "ngw" {
  count = local.subnet_count
   allocation_id = element(aws_eip.pubip.*.id, count.index)
   subnet_id = element(aws_subnet.private_globin.*.id, count.index)
    
    tags = {
       Name = "nat_gateway_${count.index}"
    }
}

resource "aws_route_table" "rtgroup" {
  count = local.subnet_count
   vpc_id = aws_vpc.globin.id
}  

resource "aws_route" "rtgroup" {
  count = local.subnet_count
  route_table_id = element(aws_route_table.rtgroup.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.ngw.*.id, count.index)
}  # end resource

resource "aws_route_table_association" "rtgroup"{
  count = local.subnet_count
  subnet_id = element(aws_subnet.private_globin.*.id, count.index)
  route_table_id = element(aws_route_table.rtgroup.*.id, count.index)
  } # end resource