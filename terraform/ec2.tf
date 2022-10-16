
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "terra-07009"
    key = "bucket/state"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = "terra"
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-instance"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sandy.id

  tags = {
    Name = "${var.name}-igw"
  }
}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.sandy.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name}-RT"
  }
}


resource "aws_route_table_association" "soundeo-RT" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "security" {
  name        = "Security"
  description = "Allow TLG  inbound traffic"
  vpc_id      = aws_vpc.sandy.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-security"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                                      = aws_vpc.sandy.id
  availability_zone                           = var.az[0]
  cidr_block                                  = var.subnet_cidr[0]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    Name = "${var.name}-subnet"
  }
}


resource "aws_subnet" "subnet-1" {
  vpc_id                                      = aws_vpc.sandy.id
  availability_zone                           = var.az[1]
  cidr_block                                  = var.subnet_cidr[1]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    Name = "${var.name}-subnet-1"
  }
}

resource "aws_vpc" "sandy" {
  cidr_block           = var.vpc_id
  enable_dns_hostnames = "true"
  instance_tenancy = "default"
  tags                 = {
    Name = "${var.name}-sandy"
  }
}


variable "vpc_id" {}
variable "subnet_cidr" {}
variable "az" {}
variable "name" {}
variable "ami" {}
variable "instance" {}


