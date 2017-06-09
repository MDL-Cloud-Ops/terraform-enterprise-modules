resource "aws_route53_record" "portal-internal" {
  zone_id = "${data.aws_route53_zone.mdl-cloud.zone_id}"
  name    = "terraform2" # This will be changed to 'terraform' once the original connectivity is removed
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_elb.portal-internal.dns_name}",
  ]

  provider = "aws.dns"
}

resource "aws_route53_record" "portal-internal-primary" {
  zone_id = "${data.aws_route53_zone.mdl-cloud.zone_id}"
  name    = "terraform"
  type    = "CNAME"
  ttl     = "300"

  records = [
    "${aws_elb.portal-internal.dns_name}",
  ]

  provider = "aws.dns"
}

resource "aws_route53_record" "portal-origin" {
  zone_id = "${data.aws_route53_zone.mckinsey-digital.zone_id}"
  name    = "terraform.origin"
  type    = "A"

  alias {
    name                   = "${lower(aws_elb.portal-public.dns_name)}"
    zone_id                = "${aws_elb.portal-public.zone_id}"
    evaluate_target_health = "false"
  }

  provider = "aws.dns"
}
