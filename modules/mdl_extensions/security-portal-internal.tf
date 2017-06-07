resource "aws_security_group" "portal-internal" {
  name   = "terraform-portal-internal"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "terraform-portal-internal"
  }
}

resource "aws_security_group_rule" "portal-internal-from-vpn" {
  security_group_id = "${aws_security_group.portal-internal.id}"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpn_access_cidr}"]
}

resource "aws_security_group_rule" "portal-internal-to-tfe" {
  security_group_id        = "${aws_security_group.portal-internal.id}"
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.terraform-enterprise-instance.id}"
}
