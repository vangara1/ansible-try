terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }

  }
}


provider "aws" {
  region = "us-east-1"
}

#provider "kubernetes" {
#  config_path    = "~/.kube/config"
#  config_context = " kubernetes-admin@kubernetes"
#  host                   = module.eks.cluster_endpoint
#  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#}

provider "kubernetes" {
  #  config_path    = "~/.kube/config"
  #  config_context = " kubernetes-admin@kubernetes"

  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  # token                  = data.aws_eks_cluster_auth.default.token

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.NAME]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.NAME]
      command     = "aws"
    }
  }
}



