# # #############################################################
# #############################################################
# ########################      processing-integration-file
# #############################################################
# #############################################################

# variable "processing-integration-file" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "processing-integration-file"
#     runtime = "nodejs18.x"
#     handler = "index.handler"
#   }
# } 


# resource "aws_lambda_function" "processing-integration-file" {
#     filename = "${path.module}/Zip/${var.processing-integration-file["name"]}.zip"
#     runtime = var.processing-integration-file["runtime"]
#     role = aws_iam_role.processing-integration-file_role.arn
#     handler = var.processing-integration-file["handler"]
#     function_name = var.processing-integration-file["name"]
#     depends_on   = [aws_iam_role_policy_attachment.processing-integration-file_attachment]
#     memory_size = 1024
#     timeout = 900
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "processing-integration-file_role" {
# name   = "processing-integration-file_role"
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
 
# resource "aws_iam_policy" "processing-integration-file_policy" {
 
#  name         = "processing-integration-file_policy"
#  description = " Policy for processing-integration-file_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "processing-integration-file_attachment" {
#  role        = aws_iam_role.processing-integration-file_role.name
#  policy_arn  = aws_iam_policy.processing-integration-file_policy.arn
# }

# resource "aws_cloudwatch_event_rule" "processing-integration-file-rule" {
#   name = "cron-12am-processing-integration-file"
#   schedule_expression = "cron(30 10 ? * * *)"
# }

# resource "aws_cloudwatch_event_target" "processing-integration-file_target" {
#   arn = aws_lambda_function.processing-integration-file.arn
#   rule = aws_cloudwatch_event_rule.processing-integration-file-rule.name
#   input = jsonencode({
#   "warmer": true
# })
# }

# resource "aws_lambda_permission" "allow_cloudwatch_to_call_processing-integration-file_lambda" {
#   statement_id = "AllowExecutionFromCloudWatch"
#   action = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.processing-integration-file.function_name
#   principal = "events.amazonaws.com"
#   source_arn = aws_cloudwatch_event_rule.processing-integration-file-rule.arn
# }

