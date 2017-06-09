variable "vpc_id" {}

variable "cert_origin_id" {}

variable "cert_internal_id" {}

variable "cert_cloudfront_id" {}

variable "instance_subnet_id" {}

variable "elb_subnet_id" {}

variable "vpn_access_cidr" {
  type = "list"
  default = []
}

variable "region" {}

variable "nat_public_ips" {
  type = "list"
  default = []
}