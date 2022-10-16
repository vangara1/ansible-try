terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  create_spot_instance                = true
  spot_type                           = var.spot_type
  spot_instance_interruption_behavior = var.spot_behavior
  associate_public_ip_address         = true
  ami                                 = var.ami
  instance_type                       = var.instance_type
  key_name                            = var.key_name
  monitoring                          = true
  vpc_security_group_ids              = [module.sg.security_group_id]
  subnet_id                           = module.vpc.public_subnets[0]

  tags = {
    Name = "${var.name}-ec2"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.name}-vpc"
  cidr               = var.CIDR
  azs                = var.AZ
  public_subnets     = var.SUBNET
  enable_nat_gateway = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

}
resource "aws_eip" "elastic-ip" {
  count = 1
  vpc   = true
  tags  = {
    name = "${var.name}-eip"
  }
}


module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.name}-sg"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks      = ["190.0.0.0/16"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
      description = ""
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

resource "tls_private_key" "wave-key" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name = var.name
  public_key = trimspace(tls_private_key.wave-key.public_key_openssh)
}



resource "null_resource" "key-wave" {
  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.wave-key.private_key_pem}' > ./'${var.name}'.pem
      sudo chmod 400 ./'${var.name}'.pem
    EOT
  }
}

variable "name" {}
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "CIDR" {}
variable "AZ" {}
variable"SUBNET"{}
variable"spot_type"{}
variable"spot_behavior"{}