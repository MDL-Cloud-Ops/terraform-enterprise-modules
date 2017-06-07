# AWS certificate IDs for the MDL CloudFront-facing ELB
variable "cert_origin_id" {}

# AWS certificate IDs for the MDL VPN-facing ELB
variable "cert_internal_id" {}

# CIDR range for VPN access to the instance
variable "vpn_access_cidr" {}

module "mdl_extensions" {
  source = "../modules/mdl_extensions"

  cert_origin_id   = "${var.cert_origin_id}"
  cert_internal_id = "${var.cert_internal_id}"
  vpc_id           = "${data.aws_subnet.instance.vpc_id}"
  elb_subnet_id    = "${var.elb_subnet_id}"
  vpn_access_cidr  = "${var.vpn_access_cidr}"
}