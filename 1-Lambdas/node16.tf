# #############################################################
#############################################################
########################splitting-demerge-file
#############################################################
#############################################################

variable "splitting-demerge-file" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "splitting-demerge-file"
    runtime = "nodejs16.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "splitting-demerge-file" {
    filename = "${path.module}/Zip/${var.splitting-demerge-file["name"]}.zip"
    runtime = var.splitting-demerge-file["runtime"]
    role = aws_iam_role.splitting-demerge-file_role.arn
    handler = var.splitting-demerge-file["handler"]
    function_name = var.splitting-demerge-file["name"]
    depends_on   = [aws_iam_role_policy_attachment.splitting-demerge-file_attachment]
    memory_size = 5048
    timeout = 600
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "splitting-demerge-file_role" {
name   = "splitting-demerge-file_role"
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
 
resource "aws_iam_policy" "splitting-demerge-file_policy" {
 
 name         = "splitting-demerge-file_policy"
 description = " Policy for splitting-demerge-file_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "splitting-demerge-file_attachment" {
 role        = aws_iam_role.splitting-demerge-file_role.name
 policy_arn  = aws_iam_policy.splitting-demerge-file_policy.arn
}

# #############################################################
#############################################################
########################ScanbaseRegistrationCrons-Prod
#############################################################
#############################################################

variable "ScanbaseRegistrationCrons-Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "ScanbaseRegistrationCrons-Prod"
    runtime = "nodejs16.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "ScanbaseRegistrationCrons-Prod" {
    filename = "${path.module}/Zip/${var.ScanbaseRegistrationCrons-Prod["name"]}.zip"
    runtime = var.ScanbaseRegistrationCrons-Prod["runtime"]
    role = aws_iam_role.ScanbaseRegistrationCrons-Prod_role.arn
    handler = var.ScanbaseRegistrationCrons-Prod["handler"]
    function_name = var.ScanbaseRegistrationCrons-Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.ScanbaseRegistrationCrons-Prod_attachment]
    memory_size = 128
    timeout = 3
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "ScanbaseRegistrationCrons-Prod_role" {
name   = "ScanbaseRegistrationCrons-Prod_role"
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
 
resource "aws_iam_policy" "ScanbaseRegistrationCrons-Prod_policy" {
 
 name         = "ScanbaseRegistrationCrons-Prod_policy"
 description = " Policy for ScanbaseRegistrationCrons-Prod_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "ScanbaseRegistrationCrons-Prod_attachment" {
 role        = aws_iam_role.ScanbaseRegistrationCrons-Prod_role.name
 policy_arn  = aws_iam_policy.ScanbaseRegistrationCrons-Prod_policy.arn
}

# #############################################################
#############################################################
########################                 CronLambdaInvocation-Prod
#############################################################
#############################################################

variable "CronLambdaInvocation-Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "CronLambdaInvocation-Prod"
    runtime = "Nodejs16.x"
    handler = "lambda_function.lambda_handler"
  }
} 


resource "aws_lambda_function" "CronLambdaInvocation-Prod" {
    filename = "${path.module}/Zip/${var.CronLambdaInvocation-Prod["name"]}.zip"
    runtime = var.CronLambdaInvocation-Prod["runtime"]
    role = aws_iam_role.CronLambdaInvocation-Prod_role.arn
    handler = var.CronLambdaInvocation-Prod["handler"]
    function_name = var.CronLambdaInvocation-Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.CronLambdaInvocation-Prod_attachment]
    memory_size = 128
    timeout = 903
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "CronLambdaInvocation-Prod_role" {
name   = "CronLambdaInvocation-Prod_role"
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
 
resource "aws_iam_policy" "CronLambdaInvocation-Prod" {
 
 name         = "CronLambdaInvocation-Prod"
 description = " Policy for CronLambdaInvocation-Prod lambda"
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
 
resource "aws_iam_role_policy_attachment" "CronLambdaInvocation-Prod_attachment" {
 role        = aws_iam_role.CronLambdaInvocation-Prod_role.name
 policy_arn  = aws_iam_policy.DT_sent_to_bank_report-Prod-Prod.arn
}