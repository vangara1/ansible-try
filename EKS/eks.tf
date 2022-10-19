module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name                    = var.NAME
  cluster_version                 = "1.22"
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  node_security_group_id          = module.sg.security_group_id
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    #    attach_cluster_primary_security_group = true
    #    create_security_group                 = false
  }
  eks_managed_node_groups = {

    name           = "${var.NAME}-1"
    instance_types = [
      "t3.small"
    ]
    min_size               = 1
    max_size               = 3
    desired_size           = 3
    vpc_security_group_ids = [module.sg.security_group_id]
  }
  tags = {
   Name = var.NAME
  }
}



