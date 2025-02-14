# #############################################################
#############################################################
########################      systemx_report_creation_module_Prod
#############################################################
#############################################################

variable "systemx_report_creation_module_Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "systemx_report_creation_module_Prod"
    runtime = "Python3.10"
    handler = "lambda_function.lambda_handler"
  }
} 


resource "aws_lambda_function" "systemx_report_creation_module_Prod" {
    filename = "${path.module}/Zip/${var.systemx_report_creation_module_Prod["name"]}.zip"
    runtime = var.systemx_report_creation_module_Prod["runtime"]
    role = aws_iam_role.systemx_report_creation_module_Prod_role.arn
    handler = var.systemx_report_creation_module_Prod["handler"]
    function_name = var.systemx_report_creation_module_Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.systemx_report_creation_module_Prod_attachment]
    memory_size = 2080
    timeout = 303
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "systemx_report_creation_module_Prod_role" {
name   = "systemx_report_creation_module_Prod_role"
assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
    }
    EOF
}
 
resource "aws_iam_policy" "systemx_report_creation_module_Prod_policy" {
 
 name         = "systemx_report_creation_module_Prod_policy"
 description = " Policy for systemx_report_creation_module_Prod_policy lambda"
 path         = "/"
 policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
      },
      {
            "Sid": "AWSLambdaVPCAccessExecutionPermissions",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSubnets",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
            ],
            "Resource": "*"
        }
    ]
    }
    EOF
    }
 
resource "aws_iam_role_policy_attachment" "systemx_report_creation_module_Prod_attachment" {
 role        = aws_iam_role.systemx_report_creation_module_Prod_role.name
 policy_arn  = aws_iam_policy.systemx_report_creation_module_Prod_policy.arn
}

