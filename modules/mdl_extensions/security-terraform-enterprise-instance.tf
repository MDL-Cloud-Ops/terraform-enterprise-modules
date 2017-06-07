resource "aws_security_group" "terraform-enterprise-instance" {
  name   = "terraform-enterprise-instance"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "terraform-enterprise-instance"
  }
}
