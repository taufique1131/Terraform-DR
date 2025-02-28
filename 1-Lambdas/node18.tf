# Private subnet id

data "aws_subnet" "PVT-APP-2b" {
    id = "subnet-0d12d13c2263e89e3"
}
data "aws_subnet" "PVT-APP-2c" {
    id = "subnet-0ded724ce358afba8"
}

# VPC ID

data "aws_vpc" "HYD-DR-VPC" {
    id = "vpc-070e1fab88acfa846"
}

# New Lambda Security group 

resource "aws_security_group" "Lambda-SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.HYD-DR-VPC.id
  
  tags = {
    Name = "allow_tls"
  }
}


#############################################################
#############################################################
########################      EnachAdoptionReports-Prod
#############################################################
#############################################################

variable "EnachAdoptionReports-Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "EnachAdoptionReports-Prod"
    runtime = "nodejs18.x"
    handler = "src/handlers/index.systemXReportHandler"
  }
} 


resource "aws_lambda_function" "EnachAdoptionReports-Prod" {
    filename = "${path.module}/Zip/${var.EnachAdoptionReports-Prod["name"]}.zip"
    runtime = var.EnachAdoptionReports-Prod["runtime"]
    role = aws_iam_role.EnachAdoptionReports-Prod_role.arn
    handler = var.EnachAdoptionReports-Prod["handler"]
    function_name = var.EnachAdoptionReports-Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.EnachAdoptionReports-Prod_attachment]
    memory_size = 1024
    timeout = 900
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "EnachAdoptionReports-Prod_role" {
name   = "EnachAdoptionReports-Prod_role"
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
 
resource "aws_iam_policy" "EnachAdoptionReports-Prod_policy" {
 
 name         = "EnachAdoptionReports-Prod_policy"
 description = " Policy for EnachAdoptionReports-Prod_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "EnachAdoptionReports-Prod_attachment" {
 role        = aws_iam_role.EnachAdoptionReports-Prod_role.name
 policy_arn  = aws_iam_policy.EnachAdoptionReports-Prod_policy.arn
}




# #############################################################
#############################################################
########################      Autopayment-API-Prod
#############################################################
#############################################################

variable "Autopayment-API-Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "Autopayment-API-Prod"
    runtime = "nodejs18.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "Autopayment-API-Prod" {
    filename = "${path.module}/Zip/${var.Autopayment-API-Prod["name"]}.zip"
    runtime = var.Autopayment-API-Prod["runtime"]
    role = aws_iam_role.Autopayment-API-Prod_role.arn
    handler = var.Autopayment-API-Prod["handler"]
    function_name = var.Autopayment-API-Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.Autopayment-API-Prod_attachment]
    memory_size = 128
    timeout = 63
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "Autopayment-API-Prod_role" {
name   = "Autopayment-API-Prod_role"
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
 
resource "aws_iam_policy" "Autopayment-API-Prod_policy" {
 
 name         = "Autopayment-API-Prod_policy"
 description = " Policy for Autopayment-API-Prod_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "Autopayment-API-Prod_attachment" {
 role        = aws_iam_role.Autopayment-API-Prod_role.name
 policy_arn  = aws_iam_policy.Autopayment-API-Prod_policy.arn
}

# #############################################################
#############################################################
########################      processing-demerge-file
#############################################################
#############################################################

variable "processing-demerge-file" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "processing-demerge-file"
    runtime = "nodejs18.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "processing-demerge-file" {
    filename = "${path.module}/Zip/${var.processing-demerge-file["name"]}.zip"
    runtime = var.processing-demerge-file["runtime"]
    role = aws_iam_role.processing-demerge-file_role.arn
    handler = var.processing-demerge-file["handler"]
    function_name = var.processing-demerge-file["name"]
    depends_on   = [aws_iam_role_policy_attachment.processing-demerge-file_attachment]
    memory_size = 4024
    timeout = 900
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "processing-demerge-file_role" {
name   = "processing-demerge-file_role"
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
 
resource "aws_iam_policy" "processing-demerge-file_policy" {
 
 name         = "processing-demerge-file_policy"
 description = " Policy for processing-demerge-file_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "processing-demerge-file_attachment" {
 role        = aws_iam_role.processing-demerge-file_role.name
 policy_arn  = aws_iam_policy.processing-demerge-file_policy.arn
}

# Lambda permission to allow S3 to invoke the function
resource "aws_lambda_permission" "s3_invocation" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.processing-demerge-file.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}

# Create the S3 bucket notification to trigger the Lambda function for .csv files in csvdata/ prefix
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.processing-demerge-file.arn
    events              = ["s3:ObjectCreated:*"]

    filter_prefix = prefix
    filter_suffix = suffix
  }

}
# #############################################################
#############################################################
########################      processing-integration-file
#############################################################
#############################################################

variable "processing-integration-file" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "processing-integration-file"
    runtime = "nodejs18.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "processing-integration-file" {
    filename = "${path.module}/Zip/${var.processing-integration-file["name"]}.zip"
    runtime = var.processing-integration-file["runtime"]
    role = aws_iam_role.processing-integration-file_role.arn
    handler = var.processing-integration-file["handler"]
    function_name = var.processing-integration-file["name"]
    depends_on   = [aws_iam_role_policy_attachment.processing-integration-file_attachment]
    memory_size = 1024
    timeout = 900
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "processing-integration-file_role" {
name   = "processing-integration-file_role"
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
 
resource "aws_iam_policy" "processing-integration-file_policy" {
 
 name         = "processing-integration-file_policy"
 description = " Policy for processing-integration-file_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "processing-integration-file_attachment" {
 role        = aws_iam_role.processing-integration-file_role.name
 policy_arn  = aws_iam_policy.processing-integration-file_policy.arn
}

# #############################################################
#############################################################
########################      notification-trigger-update-Prod
#############################################################
#############################################################

variable "notification-trigger-update-Prod" {
  type = object({
    name = string
    runtime = string
    handler = string
  })
  default = {
    name = "notification-trigger-update-Prod"
    runtime = "nodejs18.x"
    handler = "index.handler"
  }
} 


resource "aws_lambda_function" "notification-trigger-update-Prod" {
    filename = "${path.module}/Zip/${var.notification-trigger-update-Prod["name"]}.zip"
    runtime = var.notification-trigger-update-Prod["runtime"]
    role = aws_iam_role.notification-trigger-update-Prod_role.arn
    handler = var.notification-trigger-update-Prod["handler"]
    function_name = var.notification-trigger-update-Prod["name"]
    depends_on   = [aws_iam_role_policy_attachment.notification-trigger-update-Prod_attachment]
    memory_size = 128
    timeout = 123
    vpc_config {
      subnet_ids = [data.aws_subnet.PVT-APP-2b.id , data.aws_subnet.PVT-APP-2c.id]
      security_group_ids = [aws_security_group.Lambda-SG.id]
    }
}
 
resource "aws_iam_role" "notification-trigger-update-Prod_role" {
name   = "notification-trigger-update-Prod_role"
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
 
resource "aws_iam_policy" "notification-trigger-update-Prod_policy" {
 
 name         = "notification-trigger-update-Prod_policy"
 description = " Policy for notification-trigger-update-Prod_policy lambda"
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
 
resource "aws_iam_role_policy_attachment" "notification-trigger-update-Prod_attachment" {
 role        = aws_iam_role.notification-trigger-update-Prod_role.name
 policy_arn  = aws_iam_policy.notification-trigger-update-Prod_policy.arn
}

