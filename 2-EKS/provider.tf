terraform {
    backend "s3" {
      bucket = "praneeta-test-s3-copy-files"
      key = "Terraform/eks-state-file"
      region = "ap-south-1"
    }
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.85.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.17.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }

    }
}

provider "aws" {
  region = "ap-south-2" 
}

ephemeral "aws_eks_cluster_auth" "eks-hyd-dr" {
  name = aws_eks_cluster.eks-cluster-dr-hyd-cluster.id
}

provider "kubernetes" {
  host = aws_eks_cluster.eks-cluster-dr-hyd-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster-dr-hyd-cluster.certificate_authority[0].data)
  token = ephemeral.aws_eks_cluster_auth.eks-hyd-dr.token
}

provider "helm" {
  kubernetes {
    host = aws_eks_cluster.eks-cluster-dr-hyd-cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster-dr-hyd-cluster.certificate_authority[0].data)
    token = ephemeral.aws_eks_cluster_auth.eks-hyd-dr.token
  }
}