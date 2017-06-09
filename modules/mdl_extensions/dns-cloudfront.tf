resource "aws_route53_record" "cloudfront" {
  zone_id = "${data.aws_route53_zone.mckinsey-digital.zone_id}"
  name    = "terraform.mckinsey.digital"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.main.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.main.hosted_zone_id}"
    evaluate_target_health = "false"
  }

  provider = "aws.dns"
}
