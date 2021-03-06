#Create the tgw vpc that will host the TGW and the VPN-Dx connections
#Variables needed : vpcip_tgw, coid


resource "aws_vpc" "fw_vpc" {
  cidr_block       					         = var.vpcip_fw
  tags = {
    Name                             = join("", [var.coid, "-us-E-TGW"])
  }
}


/* Uncomment if you want to create a ShR VPC too

resource "aws_vpc" "shs_vpc" {
  cidr_block       					         = var.vpcip_shs
  tags = {
    Name                             = join("", [var.coid, "-us-E-ShS"])
  }
}

*/
  
#this is to create subnets on TGW vpc
#How many subnets will be created has to do on how many subnet CIDR you will have in subnets_cidr_private/public variable
#The AZs will be picked by az variable list . If you have more than subnets that AZ then it will be serially distributed accross the AZs
#default is 2 Privates, 2 publics
#Private subnet will not map a public IP automatically, where Public will do.


resource "aws_subnet" "public" {
  count                               = length(var.subnets_cidr_public)
  vpc_id                              = aws_vpc.fw_vpc.id
  cidr_block                          = element(var.subnets_cidr_public,count.index)
  availability_zone                   = element(var.azs,count.index)
  map_public_ip_on_launch             = true
  tags  = {
    Name                              = join("", [var.coid, "-us-E-FW-public-AZ${count.index+1}"])
  }
}

resource "aws_subnet" "Private" {
  count                               = length(var.subnets_cidr_private)
  vpc_id                              = aws_vpc.fw_vpc.id
  cidr_block                          = element(var.subnets_cidr_private,count.index)
  availability_zone                   = element(var.azs,count.index)
  map_public_ip_on_launch             = false
  tags = {
    Name                              = join("", [var.coid, "-us-E-FW-private-AZ${count.index+1}"])
  }
}

/* ShR Service Subnet Creation - Uncomment only when you want to create ShR infrastructure too

#Subnet Creation - SHR

resource "aws_subnet" "public_shr" {
  count                               = length(var.subnets_cidr_public_shr)
  vpc_id                              = aws_vpc.shr_vpc.id
  cidr_block                          = element(var.subnets_cidr_public_shr,count.index)
  availability_zone                   = element(var.azs,count.index)
  map_public_ip_on_launch             = true
  tags = {
    Name                              = join("", [var.coid, "-us-E-SHR-public-AZ${count.index+1}"])
  }
}

resource "aws_subnet" "Private_shr" {
  count                               = length(var.subnets_cidr_private_shr)
  vpc_id                              = aws_vpc.shr_vpc.id
  cidr_block                          = element(var.subnets_cidr_private_shr,count.index)
  availability_zone                   = element(var.azs,count.index)
  map_public_ip_on_launch             = false
  tags = {
    Name                              = join("", [var.coid, "-us-E-SHR-private-AZ${count.index+1}"])
  }
}
*/
