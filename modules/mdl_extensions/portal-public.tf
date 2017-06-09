resource "aws_elb" "portal-public" {
  name = "terraform-enterprise-public"

  subnets = ["${var.elb_subnet_id}"]

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.cert_origin_id}"
    instance_port      = 8080
    instance_protocol  = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  security_groups = ["${aws_security_group.portal-public.id}"]

  idle_timeout = 300
}
