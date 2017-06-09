resource "aws_security_group" "terraform-enterprise-instance" {
  name   = "terraform-enterprise-instance"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "terraform-enterprise-instance"
  }
}

resource "aws_security_group_rule" "terraform-enterprise-instance-ssh" {
  security_group_id = "${aws_security_group.terraform-enterprise-instance.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpn_access_cidr}"]
}

resource "aws_security_group_rule" "terraform-enterprise-instance-internal-elb" {
  security_group_id = "${aws_security_group.terraform-enterprise-instance.id}"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.portal-internal.id}"
}

resource "aws_security_group_rule" "terraform-enterprise-instance-public-elb" {
  security_group_id = "${aws_security_group.terraform-enterprise-instance.id}"
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.portal-public.id}"
}