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

# ################################################
# ###### Autopayment-API-DR-Rule
# ################################################

resource "aws_cloudwatch_event_rule" "Autopayment-API-Prod-rule" {
  name = "Autopayment-API-DR-Rule"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "Autopayment-API-Prod_target" {
  arn = aws_lambda_function.Autopayment-API-Prod.arn
  rule = aws_cloudwatch_event_rule.Autopayment-API-Prod-rule.name
}

resource "aws_lambda_permission" "allow_cloudwatch_to_Autopayment-API-Prod_lambda" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.Autopayment-API-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.Autopayment-API-Prod-rule.arn
}