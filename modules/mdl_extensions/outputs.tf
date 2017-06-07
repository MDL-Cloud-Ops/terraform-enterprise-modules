output "sg-terraform-instance-id" {
  value = "${aws_security_group.terraform-enterprise-instance.id}"
}

output "elb-internal-id" {
  value = "${aws_elb.portal-internal.id}"
}

output "elb-public-id" {
  value = "${aws_elb.portal-public.id}"
}
