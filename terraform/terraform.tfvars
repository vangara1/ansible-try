vpc_id      = "170.0.0.0/16"
subnet_cidr = ["170.0.0.0/24","170.0.1.0/24"]
az          = ["us-east-1b","us-east-1c"]
name        = "production"
ami         = "ami-002070d43b0a4f171"
instance    = "t2.micro"
ssh_key_private = "/home/centos/.ssh/id_rsa.pub"