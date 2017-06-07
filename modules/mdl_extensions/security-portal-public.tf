resource "aws_security_group" "portal-public" {
  name   = "terraform-portal-public"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "terraform-portal-public"
  }
}

data "aws_ip_ranges" "cloudfront" {
  services = ["cloudfront"]
  regions  = []
}

resource "aws_security_group_rule" "portal-public-from-cloudfront" {
  security_group_id = "${aws_security_group.portal-public.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${data.aws_ip_ranges.cloudfront.cidr_blocks}"]
}

resource "aws_security_group_rule" "portal-public-to-tfe" {
  security_group_id        = "${aws_security_group.portal-public.id}"
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.terraform-enterprise-instance.id}"
}
