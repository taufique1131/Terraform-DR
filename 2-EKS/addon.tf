##############
## vpc-cni
################
data "aws_eks_addon_version" "vpc-cni" {
  addon_name         = "vpc-cni"
  kubernetes_version = aws_eks_cluster.eks-cluster-dr-hyd-cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "vpc-cni" {
    cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
    addon_name    = "vpc-cni"
    addon_version = data.aws_eks_addon_version.vpc-cni.version
    service_account_role_arn = aws_iam_role.vpc-cni-role.arn
}

data "tls_certificate" "hyd-cluster" {
    url = aws_eks_cluster.eks-cluster-dr-hyd-cluster.identity[0].oidc[0].issuer
}

data "aws_iam_openid_connect_provider" "hyd-cluster" {
    url = aws_eks_cluster.eks-cluster-dr-hyd-cluster.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "vpc_cni_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.hyd-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.hyd-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "vpc-cni-role" {
  assume_role_policy = data.aws_iam_policy_document.vpc_cni_role_policy.json
  name               = "hyd-dr-vpc-cni-role"
}

resource "aws_iam_role_policy_attachment" "vpc-cni-role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.vpc-cni-role.name
}

##############
## kube-proxy
################
data "aws_eks_addon_version" "kube-proxy" {
  addon_name         = "kube-proxy"
  kubernetes_version = aws_eks_cluster.eks-cluster-dr-hyd-cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  addon_name    = "kube-proxy"
  addon_version = data.aws_eks_addon_version.kube-proxy.version
}


##############
## coredns
################
data "aws_eks_addon_version" "coredns" {
  addon_name         = "coredns"
  kubernetes_version = aws_eks_cluster.eks-cluster-dr-hyd-cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  addon_name    = "coredns"
  addon_version = data.aws_eks_addon_version.coredns.version
}


##############
## metrics-server
################
data "aws_eks_addon_version" "metrics-server" {
  addon_name         = "metrics-server"
  kubernetes_version = aws_eks_cluster.eks-cluster-dr-hyd-cluster.version
  most_recent        = true
}

resource "aws_eks_addon" "metrics-server" {
  cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  addon_name    = "metrics-server"
  addon_version = data.aws_eks_addon_version.metrics-server.version
}

