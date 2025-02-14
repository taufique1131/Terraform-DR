############### Private APP Subnetes for EC2 and EKS nodes
data "aws_subnet" "PVT-APP-2a" {
    id = "subnet-0faa9e5cc4c63ce4b"
}
data "aws_subnet" "PVT-APP-2b" {
    id = "subnet-0d12d13c2263e89e3"
}
data "aws_subnet" "PVT-APP-2c" {
    id = "subnet-0ded724ce358afba8"
}

resource "aws_iam_role" "eks-cluster-dr-hyd-cluster-role" {
  name = "eks-cluster-dr-hyd-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-cluster-dr-hyd-role-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-dr-hyd-cluster-role.name
}

resource "aws_eks_cluster" "eks-cluster-dr-hyd-cluster" {
  name     = "eks-cluster-dr-hyd-cluster"
  version  = var.eks_kubernetes_version
  role_arn = aws_iam_role.eks-cluster-dr-hyd-cluster-role.arn
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  vpc_config {
    endpoint_public_access = false
    endpoint_private_access = true
    subnet_ids = [
      data.aws_subnet.PVT-APP-2a.id, data.aws_subnet.PVT-APP-2b.id, data.aws_subnet.PVT-APP-2c.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks-cluster-dr-hyd-role-attachment]
}

resource "aws_eks_access_entry" "tejas" {
  cluster_name      = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  principal_arn     = "arn:aws:iam::609459977430:user/Acc-AkshayP"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "tejas" {
  cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
  principal_arn = "arn:aws:iam::609459977430:user/Acc-AkshayP"
  access_scope {
    type       = "cluster"
  }
  depends_on = [ aws_eks_access_entry.tejas ]
}

resource "aws_eks_access_entry" "jump-server" {
  cluster_name      = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  principal_arn     = "arn:aws:iam::609459977430:role/SystemX-Prod-Bastion_Role"
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "jump-server" {
  cluster_name  = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
  principal_arn = "arn:aws:iam::609459977430:role/SystemX-Prod-Bastion_Role"
  access_scope {
    type       = "cluster"
  }
  depends_on = [ aws_eks_access_entry.jump-server ]
}