module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.NAME}-sg"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = ["190.0.0.0/16"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = ""
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}