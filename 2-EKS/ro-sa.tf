data "aws_iam_policy_document" "payment-sa-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.hyd-cluster.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:systemx:payment-sa"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.hyd-cluster.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "payment-sa-role" {
  assume_role_policy = data.aws_iam_policy_document.payment-sa-policy.json
  name               = "hyd-dr-eks-payment-sa-role"
}

resource "aws_iam_role_policy_attachment" "payment-sa-secretmanager" {
  policy_arn = "arn:aws:iam::609459977430:policy/SystemX-Secreate_Manager"
  role       = aws_iam_role.payment-sa-role.name
}

resource "aws_iam_role_policy_attachment" "payment-sa-s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.payment-sa-role.name
}

/////////scanbase sa oidc assosiation

# data "aws_iam_policy_document" "scanbase-sa-policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(data.aws_iam_openid_connect_provider.hyd-cluster.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:systemx:scanb-prod-sa"]
#     }

#     principals {
#       identifiers = [data.aws_iam_openid_connect_provider.hyd-cluster.arn]
#       type        = "Federated"
#     }
#   }
# }

# resource "aws_iam_role" "scanbase-sa-role" {
#   assume_role_policy = data.aws_iam_policy_document.scanbase-sa-policy.json
#   name               = "hyd-dr-eks-scanbase-sa-role"
# }

# resource "aws_iam_role_policy_attachment" "scanbase-sa-role" {
#   policy_arn = "arn:aws:iam::609459977430:policy/SystemX-Secreate_Manager"
#   role       = aws_iam_role.scanbase-sa-role.name
# }


