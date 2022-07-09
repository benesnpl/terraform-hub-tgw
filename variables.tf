variable "aws_region" {
	default = "us-east-1"
}

variable "create_vpc_tgw" {
	default = true
}

variable "eg_tgw_vpc_name" {
	default = null
}

variable "vpcip_tgw" {
	default = "192.168.2.0/24"
}

variable "aws_access_key_id" {
	default = null
}

variable "aws_secret_access_key" {
	default = null
}

variable "coid" {
	default = "BENE"
}
