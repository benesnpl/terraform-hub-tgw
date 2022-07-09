#This creates a IGW to FW vpc for Internet access

resource "aws_internet_gateway" "main_igw" {
  depends_on                                  = [aws_ec2_transit_gateway.fw_tgw,aws_internet_gateway.main_igw]
  vpc_id                                      = aws_vpc.fw_vpc.id
  tags = {
    Name                                      = join("", [var.coid, "-FW-IGW"])
  }
}


#This creates a TGW to the Region - Note that TGWs are regional service and not bound on a specific VPC
#For easier management auto accept attachments is enabled

resource "aws_ec2_transit_gateway" "fw_tgw" {
  description                                   = "TGW"
  auto_accept_shared_attachments                = "enable"
  tags = {
   Name                                         = join("", [var.coid, "-TGW"])
  }
}


#Create FW-vpc TGW attachment
#The * is set to conclude all subnets created from the Private subnet count command

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-main" {
  depends_on                                    = [aws_ec2_transit_gateway.fw_tgw]
  subnet_ids                                    = "${aws_subnet.Private.*.id}"
  transit_gateway_id                            = aws_ec2_transit_gateway.fw_tgw.id
  vpc_id                                        = aws_vpc.fw_vpc.id
  appliance_mode_support                        = "enable"
  tags = {
   Name                                         = join("", [var.coid, "-Hub-VPC"])
  }
}

/* TGW attachment for ShR VPC - Uncomment only if you want to create ShR infrastructure
  
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-main_shr" {
  depends_on                                    = [aws_ec2_transit_gateway.fw_tgw]
  subnet_ids                                    = "${aws_subnet.Private_shr.*.id}"
  transit_gateway_id                            = aws_ec2_transit_gateway.fw_tgw.id
  vpc_id                                        = aws_vpc.shr_vpc.id
  appliance_mode_support                        = "enable"
  tags = {
   Name                                         = join("", [var.coid, "-SHR-VPC"])
  }
}
  */
  
