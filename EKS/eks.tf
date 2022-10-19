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
    ONE = {
      name           = "${var.NAME}-1"
      instance_types = [
        "t3.medium"
      ]
      min_size               = 1
      max_size               = 2
      desired_size           = 1
      vpc_security_group_ids = [module.sg.security_group_id]
    }

    TWO = {
      name           = "${var.NAME}-2"
      instance_types = [
        "t3.medium"
      ]
      min_size               = 1
      max_size               = 2
      desired_size           = 1
      vpc_security_group_ids = [module.sg.security_group_id]
    }
  }

  manage_aws_auth_configmap = true
  aws_auth_roles            = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  #  node_security_group_additional_rules = {
  #    ingress_allow_access_from_control_plane = {
  #      type                          = "ingress"
  #      protocol                      = "tcp"
  #      from_port                     = 9443
  #      to_port                       = 9443
  #      source_cluster_security_group = true
  #      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
  #    }
  #  }
}
