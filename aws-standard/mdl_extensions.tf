# AWS certificate IDs for the MDL CloudFront distribution
variable "cert_cloudfront_id" {}

# AWS certificate IDs for the MDL CloudFront-facing ELB
variable "cert_origin_id" {}

# AWS certificate IDs for the MDL VPN-facing ELB
variable "cert_internal_id" {}

# CIDR range for VPN access to the instance
variable "vpn_access_cidr" {
  type = "list"
  default = []
}

# List of public IP addresses. Not using remote state to ease transition out of Atlas SaaS
variable "nat_public_ips" {
  type = "list"
  default = []
}

# We want management of the DB engine version to be managed outside of TF code
# This allows us to apply security updates.
variable "db_engine_version" {
  type    = "string"
  default = "9.4.7"
}

module "mdl_extensions" {
  source = "../modules/mdl_extensions"

  cert_origin_id     = "${var.cert_origin_id}"
  cert_internal_id   = "${var.cert_internal_id}"
  cert_cloudfront_id = "${var.cert_cloudfront_id}"
  vpc_id             = "${data.aws_subnet.instance.vpc_id}"
  instance_subnet_id = "${var.instance_subnet_id}"
  elb_subnet_id      = "${var.elb_subnet_id}"
  vpn_access_cidr    = [ "${var.vpn_access_cidr}" ]
  region             = "${var.region}"
  nat_public_ips     = [ "${var.nat_public_ips}" ]
}
