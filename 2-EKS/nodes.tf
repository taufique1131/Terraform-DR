#################################
######## EKS Node Group Policies and Node creation
#################################


resource "aws_iam_role" "eks-nodes-dr-hyd-role" {
  name = "eks-nodes-dr-hyd-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-nodes-dr-hyd-worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodes-dr-hyd-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-dr-hyd-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodes-dr-hyd-role.name
}

resource "aws_iam_role_policy_attachment" "eks-nodes-dr-hyd-container-registry-read-only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodes-dr-hyd-role.name
}

resource "aws_eks_node_group" "eks-nodes-dr-hyd-private-nodes" {
  cluster_name    = aws_eks_cluster.eks-cluster-dr-hyd-cluster.name
  version         = var.eks_kubernetes_version
  node_group_name = "eks-nodes-dr-hyd-private-nodes"
  node_role_arn   = aws_iam_role.eks-nodes-dr-hyd-role.arn

  subnet_ids = [
    data.aws_subnet.PVT-APP-2a.id,
    data.aws_subnet.PVT-APP-2b.id,
    data.aws_subnet.PVT-APP-2c.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["m5.xlarge"]

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-nodes-dr-hyd-cni-policy,
    aws_iam_role_policy_attachment.eks-nodes-dr-hyd-container-registry-read-only,
    aws_iam_role_policy_attachment.eks-nodes-dr-hyd-worker-node-policy
  ]
  
  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}