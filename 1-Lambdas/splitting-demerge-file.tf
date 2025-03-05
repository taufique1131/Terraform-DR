# #############################################################
#############################################################
########################splitting-demerge-file
#############################################################
#############################################################

# variable "splitting-demerge-file" {
#   type = object({
#     name = string
#     runtime = string
#     handler = string
#   })
#   default = {
#     name = "splitting-demerge-file"
#     runtime = "nodejs16.x"
#     handler = "index.handler"
#   }
# } 


# resource "aws_lambda_function" "splitting-demerge-file" {
#     filename = "${path.module}/Zip/${var.splitting-demerge-file["name"]}.zip"
#     runtime = var.splitting-demerge-file["runtime"]
#     role = aws_iam_role.splitting-demerge-file_role.arn
#     handler = var.splitting-demerge-file["handler"]
#     function_name = var.splitting-demerge-file["name"]
#     depends_on   = [aws_iam_role_policy_attachment.splitting-demerge-file_attachment]
#     memory_size = 5048
#     timeout = 600
#     vpc_config {
#       subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
#       security_group_ids = [aws_security_group.Lambda-SG.id]
#     }
# }
 
# resource "aws_iam_role" "splitting-demerge-file_role" {
# name   = "splitting-demerge-file_role"
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
 
# resource "aws_iam_policy" "splitting-demerge-file_policy" {
 
#  name         = "splitting-demerge-file_policy"
#  description = " Policy for splitting-demerge-file_policy lambda"
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
 
# resource "aws_iam_role_policy_attachment" "splitting-demerge-file_attachment" {
#  role        = aws_iam_role.splitting-demerge-file_role.name
#  policy_arn  = aws_iam_policy.splitting-demerge-file_policy.arn
# }

# # Lambda permission to allow S3 to invoke the function
# resource "aws_lambda_permission" "s3_invocation" {
#   statement_id  = "AllowS3Invoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.splitting-demerge-file.function_name
#   principal     = "s3.amazonaws.com"
#   source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
# }

# # Create the S3 bucket notification to trigger the Lambda function for .csv files in csvdata/ prefix
# resource "aws_s3_bucket_notification" "bucket_notification" {
#   bucket = var.s3_bucket_name

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.splitting-demerge-file.arn
#     events              = ["s3:ObjectCreated:*"]

#     filter_prefix = prefix
#     filter_suffix = suffix
#   }
# }