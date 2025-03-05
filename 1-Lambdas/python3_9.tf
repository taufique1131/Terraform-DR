# # #############################################################
# #############################################################
# ########################       Single-account-validation-report-Prod
# #############################################################
# #############################################################

# variable "Single-account-validation-report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = " Single-account-validation-report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "Single-account-validation-report-Prod" {
#     filename = "${path.module}/Zip/${var.Single-account-validation-report-Prod["name"]}.zip"
#     runtime = var.Single-account-validation-report-Prod["runtime"]
#     role = aws_iam_role.Single-account-validation-report-Prod_role.arn
#     handler = var.Single-account-validation-report-Prod["handler"]
#     function_name = var.Single-account-validation-report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.Single-account-validation-report-Prod_attachment]
#     memory_size = 2080
#     timeout = 303
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "Single-account-validation-report-Prod_role" {
# name   = " ingle-account-validation-report-Prod_role"
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
 
# resource "aws_iam_policy" "Single-account-validation-report-Prod_policy" {
 
#  name         = "Single-account-validation-report-Prod_policy"
#  description = " Policy for Single-account-validation-report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "Single-account-validation-report-Prod_attachment" {
#  role        = aws_iam_role.Single-account-validation-report-Prod_role.name
#  policy_arn  = aws_iam_policy.Single-account-validation-report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ########################Bulk-account-validation-report-Prod
# #############################################################
# #############################################################

# variable "Bulk-account-validation-report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "Bulk-account-validation-report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "Bulk-account-validation-report-Prod" {
#     filename = "${path.module}/Zip/${var.  Bulk-account-validation-report-Prod["name"]}.zip"
#     runtime = var.Bulk-account-validation-report-Prod["runtime"]
#     role = aws_iam_role.Bulk-account-validation-report-Prod_role.arn
#     handler = var.Bulk-account-validation-report-Prod["handler"]
#     function_name = var.Bulk-account-validation-report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.Bulk-account-validation-report-Prod_attachment]
#     memory_size = 2080
#     timeout = 303
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "Bulk-account-validation-report-Prod_role" {
# name   = "Bulk-account-validation-report-Prod_role"
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
 
# resource "aws_iam_policy" "Bulk-account-validation-report-Prod_policy" {
 
#  name         = "Bulk-account-validation-report-Prod_policy"
#  description = " Policy for Bulk-account-validation-report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "Bulk-account-validation-report-Prod_attachment" {
#  role        = aws_iam_role.Bulk-account-validation-report-Prod_role.name
#  policy_arn  = aws_iam_policy.Bulk-account-validation-report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ######################## penny_drop_dump_report-Prod
# #############################################################
# #############################################################

# variable "penny_drop_dump_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "penny_drop_dump_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "penny_drop_dump_report-Prod" {
#     filename = "${path.module}/Zip/${var.penny_drop_dump_report-Prod["name"]}.zip"
#     runtime = var.penny_drop_dump_report-Prod["runtime"]
#     role = aws_iam_role.penny_drop_dump_report-Prod_role.arn
#     handler = var.penny_drop_dump_report-Prod["handler"]
#     function_name = var.penny_drop_dump_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.penny_drop_dump_report-Prod_attachment]
#     memory_size = 2080
#     timeout = 303
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "penny_drop_dump_report-Prod_role" {
# name   = "penny_drop_dump_report-Prod_role"
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
 
# resource "aws_iam_policy" "penny_drop_dump_report-Prod_policy" {
 
#  name         = "penny_drop_dump_report-Prod_policy"
#  description = " Policy for penny_drop_dump_report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "penny_drop_dump_report-Prod_attachment" {
#  role        = aws_iam_role.penny_drop_dump_report-Prod_role.name
#  policy_arn  = aws_iam_policy.penny_drop_dump_report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ######################## Reg_bank_response_report_python_report-Prod
# #############################################################
# #############################################################

# variable "Reg_bank_response_report_python_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "Reg_bank_response_report_python_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "Reg_bank_response_report_python_report-Prod" {
#     filename = "${path.module}/Zip/${var.Reg_bank_response_report_python_report-Prod["name"]}.zip"
#     runtime = var.Reg_bank_response_report_python_report-Prod["runtime"]
#     role = aws_iam_role.Reg_bank_response_report_python_report-Prod_role.arn
#     handler = var.Reg_bank_response_report_python_report-Prod["handler"]
#     function_name = var.Reg_bank_response_report_python_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.Reg_bank_response_report_python_report-Prod_attachment]
#     memory_size = 2080
#     timeout = 603
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "Reg_bank_response_report_python_report-Prod_role" {
# name   = "Reg_bank_response_report_python_report-Prod_role"
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
 
# resource "aws_iam_policy" "Reg_bank_response_report_python_report-Prod_policy" {
 
#  name         = "Reg_bank_response_report_python_report-Prod_policy"
#  description = " Policy for Reg_bank_response_report_python_report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "Reg_bank_response_report_python_report-Prod_attachment" {
#  role        = aws_iam_role.Reg_bank_response_report_python_report-Prod_role.name
#  policy_arn  = aws_iam_policy.Reg_bank_response_report_python_report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ######################## Reg_sent_to_bank_report_python_report-Prod
# #############################################################
# #############################################################

# variable "Reg_sent_to_bank_report_python_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "Reg_sent_to_bank_report_python_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "Reg_sent_to_bank_report_python_report-Prod" {
#     filename = "${path.module}/Zip/${var.Reg_sent_to_bank_report_python_report-Prod["name"]}.zip"
#     runtime = var.Reg_sent_to_bank_report_python_report-Prod["runtime"]
#     role = aws_iam_role.Reg_sent_to_bank_report_python_report-Prod_role.arn
#     handler = var.Reg_sent_to_bank_report_python_report-Prod["handler"]
#     function_name = var.Reg_sent_to_bank_report_python_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.Reg_sent_to_bank_report_python_report-Prod_attachment]
#     memory_size = 128
#     timeout = 3
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "Reg_sent_to_bank_report_python_report-Prod_role" {
# name   = "Reg_sent_to_bank_report_python_report-Prod_role"
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
 
# resource "aws_iam_policy" "Reg_sent_to_bank_report_python_report-Prod_policy" {
 
#  name         = "Reg_sent_to_bank_report_python_report-Prod_policy"
#  description = " Policy for Reg_sent_to_bank_report_python_report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "Reg_sent_to_bank_report_python_report-Prod_attachment" {
#  role        = aws_iam_role.Reg_sent_to_bank_report_python_report-Prod_role.name
#  policy_arn  = aws_iam_policy.Reg_sent_to_bank_report_python_report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ######################## DT_bank_response_report_python_report-Prod
# #############################################################
# #############################################################

# variable "DT_bank_response_report_python_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "DT_bank_response_report_python_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "DT_bank_response_report_python_report-Prod" {
#     filename = "${path.module}/Zip/${var.DT_bank_response_report_python_report-Prod["name"]}.zip"
#     runtime = var.DT_bank_response_report_python_report-Prod["runtime"]
#     role = aws_iam_role.DT_bank_response_report_python_report-Prod_role.arn
#     handler = var.DT_bank_response_report_python_report-Prod["handler"]
#     function_name = var.DT_bank_response_report_python_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.DT_bank_response_report_python_report-Prod_attachment]
#     memory_size = 2028
#     timeout = 603
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "DT_bank_response_report_python_report-Prod_role" {
# name   = "DT_bank_response_report_python_report-Prod_role"
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
 
# resource "aws_iam_policy" "DT_bank_response_report_python_report-Prod_policy" {
 
#  name         = "DT_bank_response_report_python_report-Prod_policy"
#  description = " Policy for DT_bank_response_report_python_report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "DT_bank_response_report_python_report-Prod_attachment" {
#  role        = aws_iam_role.DT_bank_response_report_python_report-Prod_role.name
#  policy_arn  = aws_iam_policy.DT_bank_response_report_python_report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ########################            DT_bank_response_report_python_report_aggregate-Prod
# #############################################################
# #############################################################

# variable "DT_bank_response_report_python_report_aggregate-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "DT_bank_response_report_python_report_aggregate-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "DT_bank_response_report_python_report_aggregate-Prod" {
#     filename = "${path.module}/Zip/${var.DT_bank_response_report_python_report_aggregate-Prod["name"]}.zip"
#     runtime = var.DT_bank_response_report_python_report_aggregate-Prod["runtime"]
#     role = aws_iam_role.DT_bank_response_report_python_report_aggregate-Prod_role.arn
#     handler = var.DT_bank_response_report_python_report_aggregate-Prod["handler"]
#     function_name = var.DT_bank_response_report_python_report_aggregate-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.DT_bank_response_report_python_report_aggregate-Prod_attachment]
#     memory_size = 2028
#     timeout = 603
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "DT_bank_response_report_python_report_aggregate-Prod_role" {
# name   = "DT_bank_response_report_python_report_aggregate-Prod_role"
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
 
# resource "aws_iam_policy" "DT_bank_response_report_python_report_aggregate-Prod_policy" {
 
#  name         = "DT_bank_response_report_python_report_aggregate-Prod_policy"
#  description = " Policy for DT_bank_response_report_python_report_aggregate-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "DT_bank_response_report_python_report_aggregate-Prod_attachment" {
#  role        = aws_iam_role.DT_bank_response_report_python_report_aggregate-Prod_role.name
#  policy_arn  = aws_iam_policy.DT_bank_response_report_python_report_aggregate-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ########################               DT_re_presentation_response_from_bank-Prod
# #############################################################
# #############################################################

# variable "DT_re_presentation_response_from_bank-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "DT_re_presentation_response_from_bank-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "DT_re_presentation_response_from_bank-Prod" {
#     filename = "${path.module}/Zip/${var.DT_re_presentation_response_from_bank-Prod["name"]}.zip"
#     runtime = var.DT_re_presentation_response_from_bank-Prod["runtime"]
#     role = aws_iam_role.DT_re_presentation_response_from_bank-Prod_role.arn
#     handler = var.DT_re_presentation_response_from_bank-Prod["handler"]
#     function_name = var.DT_re_presentation_response_from_bank-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.DT_re_presentation_response_from_bank-Prod_attachment]
#     memory_size = 2028
#     timeout = 903
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "DT_re_presentation_response_from_bank-Prod_role" {
# name   = "DT_re_presentation_response_from_bank-Prod_role"
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
 
# resource "aws_iam_policy" "DT_re_presentation_response_from_bank-Prod_policy" {
 
#  name         = "DT_re_presentation_response_from_bank-Prod_policy"
#  description = " Policy for DT_re_presentation_response_from_bank-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "DT_re_presentation_response_from_bank-Prod_attachment" {
#  role        = aws_iam_role.DT_re_presentation_response_from_bank-Prod_role.name
#  policy_arn  = aws_iam_policy.DT_re_presentation_response_from_bank-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ########################                DT_representation_bounce_report_python_report-Prod
# #############################################################
# #############################################################

# variable "DT_representation_bounce_report_python_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "DT_representation_bounce_report_python_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "DT_representation_bounce_report_python_report-Prod" {
#     filename = "${path.module}/Zip/${var.DT_representation_bounce_report_python_report-Prod["name"]}.zip"
#     runtime = var.DT_representation_bounce_report_python_report-Prod["runtime"]
#     role = aws_iam_role.DT_representation_bounce_report_python_report-Prod_role.arn
#     handler = var.DT_representation_bounce_report_python_report-Prod["handler"]
#     function_name = var.DT_representation_bounce_report_python_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.DT_representation_bounce_report_python_report-Prod_attachment]
#     memory_size = 2028
#     timeout = 603
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "DT_representation_bounce_report_python_report-Prod_role" {
# name   = "DT_representation_bounce_report_python_report-Prod_role"
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
 
# resource "aws_iam_policy" "DT_representation_bounce_report_python_report-Prod_policy" {
 
#  name         = "DT_representation_bounce_report_python_report-Prod_policy"
#  description = " Policy for DT_representation_bounce_report_python_report-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "DT_representation_bounce_report_python_report-Prod_attachment" {
#  role        = aws_iam_role.DT_representation_bounce_report_python_report-Prod_role.name
#  policy_arn  = aws_iam_policy.DT_representation_bounce_report_python_report-Prod_policy.arn
# }

# # #############################################################
# #############################################################
# ########################                 DT_representation_sent_to_bank_report-Prod
# #############################################################
# #############################################################

# variable "DT_representation_sent_to_bank_report-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "DT_representation_sent_to_bank_report-Prod"
#     runtime = "Python3.9"
#     handler = "lambda_function.lambda_handler"
#   }
# } 


# resource "aws_lambda_function" "DT_representation_sent_to_bank_report-Prod" {
#     filename = "${path.module}/Zip/${var.DT_representation_sent_to_bank_report-Prod["name"]}.zip"
#     runtime = var.DT_representation_sent_to_bank_report-Prod["runtime"]
#     role = aws_iam_role.DT_representation_sent_to_bank_report-Prod_role.arn
#     handler = var.DT_representation_sent_to_bank_report-Prod["handler"]
#     function_name = var.DT_representation_sent_to_bank_report-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.DT_representation_sent_to_bank_report-Prod_attachment]
#     memory_size = 207
#     timeout = 603
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "DT_representation_sent_to_bank_report-Prod_role" {
# name   = "DT_representation_sent_to_bank_report-Prod_role"
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
 
# resource "aws_iam_policy" "DT_sent_to_bank_report-Prod-Prod" {
 
#  name         = "DT_sent_to_bank_report-Prod-Prod"
#  description = " Policy for DT_sent_to_bank_report-Prod-Prod lambda"
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
 
# resource "aws_iam_role_policy_attachment" "DT_representation_sent_to_bank_report-Prod_attachment" {
#  role        = aws_iam_role.DT_representation_sent_to_bank_report-Prod_role.name
#  policy_arn  = aws_iam_policy.DT_sent_to_bank_report-Prod-Prod.arn
# }

