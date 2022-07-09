variable "aws_region" {
	default = eastus
}

variable "create_vpc_tgw" {
	default = True
}

variable "eg_tgw_vpc_name" {
	default = null
}

variable "vpcip_tgw" {
	default = "192.168.2.0/24"
}
