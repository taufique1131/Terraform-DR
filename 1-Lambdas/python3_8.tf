# # #############################################################
# #############################################################
# ########################upi_autopay_pdn_report_prod
# #############################################################
# #############################################################

# variable "upi_autopay_pdn_report_prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "upi_autopay_pdn_report_prod"
#     runtime = "Python3.8"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "upi_autopay_pdn_report_prod" {
#     filename = "${path.module}/Zip/${var.upi_autopay_pdn_report_prod["name"]}.zip"
#     runtime = var.upi_autopay_pdn_report_prod["runtime"]
#     role = aws_iam_role.upi_autopay_pdn_report_prod_role.arn
#     handler = var.upi_autopay_pdn_report_prod["handler"]
#     function_name = var.upi_autopay_pdn_report_prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.upi_autopay_pdn_report_prod_attachment]
#     memory_size = 128
#     timeout = 903
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "upi_autopay_pdn_report_prod_role" {
# name   = "upi_autopay_pdn_report_prod_role"
# assume_role_policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         },
#         "Effect": "Allow",
#         "Sid": ""
#       }
#     ]
#     }
#     EOF
# }
 
# resource "aws_iam_policy" "upi_autopay_pdn_report_prod" {
 
#  name         = "upi_autopay_pdn_report_prod"
#  description = " Policy for upi_autopay_pdn_report_prod lambda"
#  path         = "/"
#  policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         "Resource": "arn:aws:logs:*:*:*",
#         "Effect": "Allow"
#       },
#       {
#             "Sid": "AWSLambdaVPCAccessExecutionPermissions",
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents",
#                 "ec2:CreateNetworkInterface",
#                 "ec2:DescribeNetworkInterfaces",
#                 "ec2:DescribeSubnets",
#                 "ec2:DeleteNetworkInterface",
#                 "ec2:AssignPrivateIpAddresses",
#                 "ec2:UnassignPrivateIpAddresses"
#             ],
#             "Resource": "*"
#         }
#     ]
#     }
#     EOF
#     }
 
# resource "aws_iam_role_policy_attachment" "upi_autopay_pdn_report_prod_attachment" {
#  role        = aws_iam_role.upi_autopay_pdn_report_prod_role.name
#  policy_arn  = aws_iam_policy.DT_sent_to_bank_report-Prod-Prod.arn
# }

# # #############################################################
# #############################################################
# ########################upi_autopay_emi_report_prod
# #############################################################
# #############################################################

# variable "upi_autopay_emi_report_prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "upi_autopay_emi_report_prod"
#     runtime = "Python3.8"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "upi_autopay_emi_report_prod" {
#     filename = "${path.module}/Zip/${var.upi_autopay_emi_report_prod["name"]}.zip"
#     runtime = var.upi_autopay_emi_report_prod["runtime"]
#     role = aws_iam_role.upi_autopay_emi_report_prod_role.arn
#     handler = var.upi_autopay_emi_report_prod["handler"]
#     function_name = var.upi_autopay_emi_report_prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.upi_autopay_emi_report_prod_attachment]
#     memory_size = 128
#     timeout = 903
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "upi_autopay_emi_report_prod_role" {
# name   = "upi_autopay_emi_report_prod_role"
# assume_role_policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#           "Service": "lambda.amazonaws.com"
#         },
#         "Effect": "Allow",
#         "Sid": ""
#       }
#     ]
#     }
#     EOF
# }
 
# resource "aws_iam_policy" "upi_autopay_emi_report_prod_role" {
 
#  name         = "upi_autopay_emi_report_prod_role"
#  description = " Policy for upi_autopay_emi_report_prod_role lambda"
#  path         = "/"
#  policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         "Resource": "arn:aws:logs:*:*:*",
#         "Effect": "Allow"
#       },
#       {
#             "Sid": "AWSLambdaVPCAccessExecutionPermissions",
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents",
#                 "ec2:CreateNetworkInterface",
#                 "ec2:DescribeNetworkInterfaces",
#                 "ec2:DescribeSubnets",
#                 "ec2:DeleteNetworkInterface",
#                 "ec2:AssignPrivateIpAddresses",
#                 "ec2:UnassignPrivateIpAddresses"
#             ],
#             "Resource": "*"
#         }
#     ]
#     }
#     EOF
#     }
 
# resource "aws_iam_role_policy_attachment" "upi_autopay_emi_report_prod_attachment" {
#  role        = aws_iam_role.upi_autopay_emi_report_prod_role.name
#  policy_arn  = aws_iam_policy.DT_sent_to_bank_report-Prod-Prod.arn
# }

