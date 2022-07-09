#Security group for Public Subnet in FW VPC
#All the subnets and the ports are read from Dynamic list as a variable

 resource "aws_security_group" "public_sg" {
  name                                          = "public_sg"
  description                                   = "public SG"
  vpc_id                                        = aws_vpc.fw_vpc.id

  dynamic "ingress" {
    for_each                                    = var.rules_inbound_public_sg
    content {
      from_port                                 = ingress.value["port"]
      to_port                                   = ingress.value["port"]
      protocol                                  = ingress.value["proto"]
      cidr_blocks                               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                                    = var.rules_outbound_public_sg
    content {
      from_port                                 = egress.value["port"]
      to_port                                   = egress.value["port"]
      protocol                                  = egress.value["proto"]
      cidr_blocks                               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name                                        = join("", [var.coid, "-FW-Public-SG"])
  }
}

#Private SG for FW VPC

 resource "aws_security_group" "private_sg" {
  name                                          = "private_sg"
  description                                   = "Private SG"
  vpc_id                                        = aws_vpc.fw_vpc.id

  dynamic "ingress" {
    for_each                                    = var.rules_inbound_private_sg
    content {
      from_port                                 = ingress.value["port"]
      to_port                                   = ingress.value["port"]
      protocol                                  = ingress.value["proto"]
      cidr_blocks                               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                                    = var.rules_outbound_private_sg
    content {
      from_port                                 = egress.value["port"]
      to_port                                   = egress.value["port"]
      protocol                                  = egress.value["proto"]
      cidr_blocks                               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name                                        = join("", [var.coid, "-FW-Private-sg"])
  }
} 

/* Same applias if we need to create sh for ShR - Please uncomment
  
 resource "aws_security_group" "public_sg_shr" {
  name                                          = "public_sg_shr"
  description                                   = "public SG_SHR"
  vpc_id                                        = aws_vpc.shr_vpc.id

  dynamic "ingress" {
    for_each                                    = var.rules_inbound_public_sg_shr
    content {
      from_port                                 = ingress.value["port"]
      to_port                                   = ingress.value["port"]
      protocol                                  = ingress.value["proto"]
      cidr_blocks                               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                                    = var.rules_outbound_public_sg_shr
    content {
      from_port                                 = egress.value["port"]
      to_port                                   = egress.value["port"]
      protocol                                  = egress.value["proto"]
      cidr_blocks                               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name                                        = join("", [var.coid, "-SHR-Public-SG"])
  }
}
  
 resource "aws_security_group" "private_sg_shr" {
  name                                          = "private_sg_shr"
  description                                   = "Private SG_SHR"
  vpc_id                                        = aws_vpc.shr_vpc.id

  dynamic "ingress" {
    for_each                                    = var.rules_inbound_private_sg_shr
    content {
      from_port                                 = ingress.value["port"]
      to_port                                   = ingress.value["port"]
      protocol                                  = ingress.value["proto"]
      cidr_blocks                               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                                    = var.rules_outbound_private_sg_shr
    content {
      from_port                                 = egress.value["port"]
      to_port                                   = egress.value["port"]
      protocol                                  = egress.value["proto"]
      cidr_blocks                               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name                                        = join("", [var.coid, "-SHR-Private-sg"])
  }
} 
*/
