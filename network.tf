# create vpc network
provider "aws" {}
  #access_key = .......
  #secret_key = .......
  #region = eu-central


# create vpc
resource "aws_vpc" "globin" {
 cidr_block = "10.0.0.0/24" # 4 create subnet
 enable_dns_hostnames = true
}

# Несколько EIP, связанных с одним сетевым интерфейсом vpc
resource "aws_network_interface" "eipsub" {
  subnet_id = aws_subnet.private_globin_0.id #как соединить 
  private_ips = ["10.0.1.0/28"]
}
resource "aws_eip" "one" {
   vpc = true
   network_interface = aws_network_interface.eipsub.id
   associate_with_private_ip = "10.0.1.0/28"
}
resource "aws_network_interface" "eipsub1" {
  subnet_id = aws_subnet.private_globin_1.id #как соединить 
  private_ips = ["10.0.2.0/28"]
}

resource "aws_eip" "two" {
   vpc = true
   network_interface = aws_network_interface.eipsub1.id
   associate_with_private_ip = "10.0.2.0/28"
}



resource "aws_nat_gateway" "ng" {
   allocation_id = aws_eip.one.id
   subnet_id = aws_subnet.private_globin_0.id
    
    tags = {
       Name = "ng NAT" 
    }
  } 
resource "aws_nat_gateway" "ng1" {
   allocation_id = aws_eip.two.id
   subnet_id = aws_subnet.private_globin_1.id
    
    tags = {
       NAme = "ng1 NAT"
    } 
   }

   


# create route table
 resource "aws_route_table" "rout" {
  vpc_id = aws_vpc.globin.id
}



# как прописать с двух eip один в NAT gateway?

#создаем route table и связываем с subnet , 
#vpc nat gatawey потом создаем nat gatewey
#потом создаем  network ACL




















/*
# variable работают с  регион и az
#create var AZ
variable "region_number" {
 default = {
 eu-central-1a = 1
 eu-central-1b = 2
 }
}    # from variable create AZ
variable "az_number" {
  default = {
  a = 1
  b = 2
 }
}
*/


#locals {
# private_subnets = ["10.0.1.0/28", "10.0.2.0/28"]
# }