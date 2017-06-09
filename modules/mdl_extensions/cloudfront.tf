resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = "terraform.origin.mckinsey.digital"
    origin_id   = "terraform.origin.mckinsey.digital"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  comment         = "Managed by Terraform"
  is_ipv6_enabled = true

  /* Bucket does not exist at this time
  logging_config {
    include_cookies = false
    bucket          = "${var.bucket}"
    prefix          = "terraform.mckinsey.digital"
  }
  */

  aliases = [ "terraform.mckinsey.digital" ]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "terraform.origin.mckinsey.digital"

    compress = true

    forwarded_values {
      query_string = true

      # If you configure CloudFront to forward all headers to your origin, CloudFront doesn't cache the objects associated with this cache behavior. Instead, it sends every request to the origin.
      headers = [ "*" ]

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 300
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = "${var.cert_cloudfront_id}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  web_acl_id = "${aws_waf_web_acl.ipwl.id}"

  retain_on_delete = true

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}