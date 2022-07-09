#Creation - Association of Route table for FW vpc
#Public subnets rt

resource "aws_route_table" "public_rt" {
  depends_on                                = [aws_internet_gateway.main_igw,aws_ec2_transit_gateway.fw_tgw,aws_vpn_connection.Miami]
  vpc_id                                    = aws_vpc.fw_vpc.id
  
  route {
    cidr_block                              = "0.0.0.0/0"
    gateway_id                              = aws_internet_gateway.main_igw.id
  }
  
  
  tags = {
    Name                                     = join("", [var.coid, "-fw-public-rt00"])
  }
}

#Private Routing table


resource "aws_route_table" "private_rt" {
  depends_on                                = [aws_internet_gateway.main_igw,aws_ec2_transit_gateway.fw_tgw,aws_vpn_connection.Miami]
  vpc_id                                    = aws_vpc.fw_vpc.id
  
  route {
    cidr_block                              = "0.0.0.0/0"
    gateway_id                              = aws_ec2_transit_gateway.fw_tgw.id
  }
  
  
  tags = {
    Name                                    = join("", [var.coid, "-fw-private-rt00"])
  }
}

#Association of Private and Public Subnets RT to the subnets

resource "aws_route_table_association" "prvt" {
  depends_on                                = [aws_route_table.private_rt]
  count                                     = length(var.subnets_cidr_private)
  subnet_id                                 = element(aws_subnet.Private.*.id,count.index)
  route_table_id                            = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "public" {
  depends_on                                = [aws_route_table.public_rt]
  count                                     = length(var.subnets_cidr_public)
  subnet_id                                 = element(aws_subnet.public.*.id,count.index)
  route_table_id                            = aws_route_table.public_rt.id
}

/* Same process if we need ShR too - Please uncomment if needed

resource "aws_route_table" "public_rt_shr" {
  depends_on                                = [aws_ec2_transit_gateway.fw_tgw,aws_internet_gateway.main_igw_shr]
  vpc_id                                    = aws_vpc.shr_vpc.id
  
  route {
    cidr_block                              = "0.0.0.0/0"
    gateway_id                              = aws_internet_gateway.main_igw_shr.id
  }
  
  
  tags = {
    Name                                    = join("", [var.coid, "-shr-public-rt00"])
  }
}


resource "aws_route_table" "private_rt_shr" {
  depends_on                                = [aws_internet_gateway.main_igw_shr,aws_ec2_transit_gateway.fw_tgw,aws_vpn_connection.Miami]
  vpc_id                                    = aws_vpc.shr_vpc.id
  
  route {
    cidr_block                              = "0.0.0.0/0"
    gateway_id                              = aws_ec2_transit_gateway.fw_tgw.id
  }
  
  
  tags = {
    Name                                    = join("", [var.coid, "-shr-private-rt00"])
  }
}


resource "aws_route_table_association" "prvt_shr" {
  depends_on                                = [aws_route_table.private_rt_shr]
  count                                     = length(var.subnets_cidr_private_shr)
  subnet_id                                 = element(aws_subnet.Private_shr.*.id,count.index)
  route_table_id                            = aws_route_table.private_rt_shr.id
}

resource "aws_route_table_association" "public_shr" {
  depends_on                                = [aws_route_table.public_rt_shr]
  count                                     = length(var.subnets_cidr_public_shr)
  subnet_id                                 = element(aws_subnet.public_shr.*.id,count.index)
  route_table_id                            = aws_route_table.public_rt_shr.id
}
*/
  
