provider "aws" {
  region     = "${var.region}"

  alias = "dns"
}

data "aws_route53_zone" "mdl-cloud" {
  name = "mdl.cloud."
}

data "aws_route53_zone" "mckinsey-digital" {
  name = "mckinsey.digital."
}