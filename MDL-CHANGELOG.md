## 2017-06-07

  * Creation of new `mdl_master` default branch, matching existing `master`
  * Introduction of two new side-by-side ELBs to support VPN and CloudFront
    access. Existing ELB to be removed subsequently
  * Introduction of new `terraform-enterprise-instance` security group to
    enable networking to/from the ELBs
  * Register new ELBs in DNS
  * Add SSH connectivity to instances directly from VPN
