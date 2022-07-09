#Create the tgw vpc that will host the TGW and the VPN-Dx connections
#Variables needed : vpcip_tgw, coid
#With the count command we check if the VPC is already configured or we need to create a new one. The logic is If create_vpc_tgw is True (Boolean) then count = 1 
#else count =0

resource "aws_vpc" "tgw_vpc" {
  count                              = var.create_vpc_tgw ? 1 : 0
  cidr_block       					         = var.vpcip_tgw
  tags = 
  {
    Name                             = join("", [var.coid, "-us-E-TGW"])
  }
}

#In case there is an already existing VPC for tgw, we take the value with a Data block, without creating a new one.
#We check the condition with the same Boolean variable and the count property
#We need to have a variable with the name tag of the existing TGW VPC

data "aws_vpc" "tgw_vpc" {
  count                              = var.create_vpc_tgw ? 0 : 1
  filter {
    name                             = "tag:Name"
    values                           = [var.eg_tgw_vpc_name]
  }
}

