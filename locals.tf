locals {
   tgw_vpc_id                          = "${var.create_vpc_tgw ? aws_vpc.tgw_vpc[count.index].id : data.aws_vpc.tgw_vpc[count.index].id}"
}
