module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.NAME}-vpc"
  cidr               = var.CIDR
  azs                = var.AZ
  public_subnets     = var.SUBNET
   enable_dns_hostnames = true

}






