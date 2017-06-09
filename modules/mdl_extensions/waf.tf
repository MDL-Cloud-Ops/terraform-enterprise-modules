data "template_file" "waf" {
  template = "terraform-enterprise"
}

resource "aws_waf_web_acl" "ipwl" {
  name        = "${data.template_file.waf.rendered}/ipwl"
  metric_name = "TerraformMcKinseyDigitalIPWL"

  default_action {
    type = "BLOCK"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.internal.id}"
  }

  rules {
    action {
      type = "ALLOW"
    }

    priority = 2
    rule_id  = "${aws_waf_rule.loopback.id}"
  }
}

resource "aws_waf_rule" "internal" {
  name        = "terraform-enterprise/whitelist/internal"
  metric_name = "TerraformMcKinseyDigitalInternal"

  predicates {
    data_id = "${aws_waf_ipset.internal.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_rule" "loopback" {
  name        = "terraform-enterprise/whitelist/loopback"
  metric_name = "TerraformMcKinseyDigitalLoopback"

  predicates {
    data_id = "${aws_waf_ipset.loopback.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_ipset" "loopback" {
  name = "terraform-enterprise/loopback"

  ip_set_descriptors {
    type  = "IPV4"
    value = "${length(var.nat_public_ips) > 0 ? element(var.nat_public_ips, 0) : "127.0.0.1/32"}"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "${length(var.nat_public_ips) > 1 ? element(var.nat_public_ips, 1) : "127.0.0.2/32"}"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "${length(var.nat_public_ips) > 2 ? element(var.nat_public_ips, 2) : "127.0.0.3/32"}"
  }

  ip_set_descriptors {
    type  = "IPV4"
    value = "${length(var.nat_public_ips) > 3 ? element(var.nat_public_ips, 3) : "127.0.0.4/32"}"
  }

}