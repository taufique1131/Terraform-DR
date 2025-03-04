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







