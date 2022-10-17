vpc_id      = "170.0.0.0/16"
subnet_cidr = ["170.0.0.0/24","170.0.1.0/24"]
az          = ["us-east-1b","us-east-1c"]
name        = "production"
ami         = "ami-002070d43b0a4f171"
instance    = "t2.micro"
ssh_key_private = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDxNY2kPbsCQ8eS7yCyEG/Y+xJZ8m35mto8ybO0oFRa7EwKaEL4APqhB9XbFCLGga2k1iszdBii0iNKcG08DhF4W5mqLxu3IxSd9JfV3dznqPFR4QTPwwUOsLCujy+O5pARrzdb3PSslvt2Rd1WsDieKap3fzYn0Vhkoe/Sc0Hj2aiJsCspQCDdWZ/vaE2yNt/alzlqmqy0Nxvi4n6yc3pdMXH5BfvcW5F35oOqtbMilkM1THqaQsRZ18FEtU8Mjn4L6xMMNXHKnQkCo1Vi8ZXFul1BSrOEFdWKxmRGtuDjUg5xWUWOfPpWCxta94XRGTgYx6NADNsZ4Cjrpx0REcrp centos@ip-10-0-69-202.ec2.internal"