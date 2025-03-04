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

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule" {
  name = "share-scan-reg-files-1"
  schedule_expression = "cron(30 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule.name
  input = jsonencode({
  "name": "shareScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-rule-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule.arn
}

