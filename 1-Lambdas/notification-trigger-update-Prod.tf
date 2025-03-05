# # #############################################################
# #############################################################
# ########################      notification-trigger-update-Prod
# #############################################################
# #############################################################

# variable "notification-trigger-update-Prod" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "notification-trigger-update-Prod"
#     runtime = "nodejs18.x"
#     handler = "index.handler"
#   }
# } 


# resource "aws_lambda_function" "notification-trigger-update-Prod" {
#     filename = "${path.module}/Zip/${var.notification-trigger-update-Prod["name"]}.zip"
#     runtime = var.notification-trigger-update-Prod["runtime"]
#     role = aws_iam_role.notification-trigger-update-Prod_role.arn
#     handler = var.notification-trigger-update-Prod["handler"]
#     function_name = var.notification-trigger-update-Prod["name"]
#     depends_on   = [aws_iam_role_policy_attachment.notification-trigger-update-Prod_attachment]
#     memory_size = 128
#     timeout = 123
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "notification-trigger-update-Prod_role" {
# name   = "notification-trigger-update-Prod_role"
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
 
# resource "aws_iam_policy" "notification-trigger-update-Prod_policy" {
 
#  name         = "notification-trigger-update-Prod_policy"
#  description = " Policy for notification-trigger-update-Prod_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "notification-trigger-update-Prod_attachment" {
#  role        = aws_iam_role.notification-trigger-update-Prod_role.name
#  policy_arn  = aws_iam_policy.notification-trigger-update-Prod_policy.arn
# }

# resource "aws_cloudwatch_event_rule" "notification-trigger-update-rule" {
#   name = "Update-s3-notification"
#   schedule_expression = "cron(32 18 * * ? *)"
# }

# resource "aws_cloudwatch_event_target" "notification-trigger-update_target" {
#   arn = aws_lambda_function.notification-trigger-update-Prod.arn
#   rule = aws_cloudwatch_event_rule.notification-trigger-update-rule.name
# }

# resource "aws_lambda_permission" "allow_cloudwatch_to_call_notification-trigger-update_lambda" {
#   statement_id = "AllowExecutionFromCloudWatch"
#   action = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.notification-trigger-update-Prod.function_name
#   principal = "events.amazonaws.com"
#   source_arn = aws_cloudwatch_event_rule.notification-trigger-update-rule.arn
# }