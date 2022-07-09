#Creation of Customer GW
#Oakbrook

resource "aws_customer_gateway" "oakbrook" {
  bgp_asn                             = 65000
  ip_address                          = var.il_external
  type                                = "ipsec.1"

  tags = {
    Name                              = join("", [var.coid, "-Oakbrook-CGW"])
  }
}

#Miami

resource "aws_customer_gateway" "miami" {
  bgp_asn                              = 65000
  ip_address                           = var.fl_external
  type                                 = "ipsec.1"

  tags = {
    Name                               = join("", [var.coid, "-Miami-CGW"])
  }
} 

#Creation of Oakbrook VPN Connection on TGW

 resource "aws_vpn_connection" "Oakbrook" {
  transit_gateway_id                    = aws_ec2_transit_gateway.fw_tgw.id
  customer_gateway_id                   = aws_customer_gateway.oakbrook.id
  type                                  = "ipsec.1"
  static_routes_only                    = true
  tags = {
    Name                                = join("", [var.coid, "-Oakbrook-ipsec"])
  }
 }

#Creation of Oakbrook VPN Connection on TGW

 resource "aws_vpn_connection" "Miami" {
  transit_gateway_id                    = aws_ec2_transit_gateway.fw_tgw.id
  customer_gateway_id                   = aws_customer_gateway.miami.id
  type                                  = "ipsec.1"
  static_routes_only                    = true
  tags = {
    Name                                = join("", [var.coid, "-Miami-ipsec"])
  }
}
 
  
