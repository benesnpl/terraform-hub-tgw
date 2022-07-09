#Create the tgw vpc that will host the TGW and the VPN-Dx connections
#Variables needed : vpcip_tgw, coid


resource "aws_vpc" "tgw_vpc" {
  count                              = var.create_vpc_tgw ? 1 : 0
  cidr_block       					         = var.vpcip_tgw
  tags = {
    Name                             = join("", [var.coid, "-us-E-TGW"])
  }
}


#There is the posibility to create the ShS VPC too for LM etc. Set variable shs_vpc to true and give cidr for the ShS vpc

resource "aws_vpc" "shs_vpc" {
  count                              = var.create_vpc_shs ? 1 : 0
  cidr_block       					         = var.vpcip_tgw
  tags = {
    Name                             = join("", [var.coid, "-us-E-TGW"])
  }
}
