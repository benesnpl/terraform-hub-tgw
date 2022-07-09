#Variables For Connection


variable "aws_access_key_id" {
	default = "AKIA2I3LMA5XH4SEF5HD"
}

variable "aws_secret_access_key" {
	default = "YVIXhSaBC7lodVrECzSTUBjodZ4SSEmQRqqhPlBR"
}

#Variables for general Account setup

variable "coid" {
	default = "BENE"
}


variable "coid" {
	default = "BENE"
}


#VPC and subnets

variable "create_vpc_shs" {
	default = false
}


variable "vpcip_tgw" {
	default = "192.168.2.0/24"
}

variable "vpcip_shs" {
	default = "192.168.3.0/24"
}

variable "subnets_cidr_public" {
	type = list
	default = null
}

variable "subnets_cidr_private" {
	type = list
	default = null
}

/* Uncomment this part when you choose to deploy ShS VPC too

variable "subnets_cidr_public_shr" {
	type = list
	default = null
}

variable "subnets_cidr_private_shr" {
	type = list
	default = null
}

*/
	



