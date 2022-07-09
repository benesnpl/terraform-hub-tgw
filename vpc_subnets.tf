#Create the tgw vpc that will host the TGW and the VPN-Dx connections
#Variables needed : vpcip_tgw, coid


resource "aws_vpc" "tgw_vpc" {
  cidr_block       					         = var.vpcip_tgw
  tags = {
    Name                             = join("", [var.coid, "-us-E-TGW"])
  }
}


#There is the posibility to create the ShS VPC too for LM etc. Set variable shs_vpc to true and give cidr for the ShS vpc

resource "aws_vpc" "shs_vpc" {
  count                              = var.create_vpc_shs ? 1 : 0
  cidr_block       					         = var.vpcip_shs
  tags = {
    Name                             = join("", [var.coid, "-us-E-ShS"])
  }
}


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
