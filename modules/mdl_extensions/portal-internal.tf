resource "aws_elb" "portal-internal" {
  name     = "terraform-enterprise-internal"
  internal = true

  subnets = ["${var.elb_subnet_id}"]

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = 8080
    instance_protocol  = "http"
    ssl_certificate_id = "${var.cert_internal_id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  security_groups = ["${aws_security_group.portal-internal.id}"]

  idle_timeout = 300

  tags {
    Name = "terraform-enterprise-internal"
  }
}
