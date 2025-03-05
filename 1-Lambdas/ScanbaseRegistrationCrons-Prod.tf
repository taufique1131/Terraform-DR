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

# ################################################
# ###### share-scan-reg-files-1-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-1" {
  name = "share-scan-reg-files-1"
  schedule_expression = "cron(30 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-1" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-1.name
  input = jsonencode({
  "name": "shareScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-1" {
  statement_id = "AllowExecutionFromCloudWatch-1"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-1.arn
}

# ################################################
# ###### share-scan-reg-files-2-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-2" {
  name = "share-scan-reg-files-2-Prod"
  schedule_expression = "cron(30 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-2" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-2.name
  input = jsonencode({
  "name": "shareScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-2" {
  statement_id = "AllowExecutionFromCloudWatch-2"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-2.arn
}

# ################################################
# ###### create-scan-reg-files-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-3" {
  name = "create-scan-reg-files-Prod"
  schedule_expression = "cron(15 4 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-3" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-3.name
  input = jsonencode({
  "name": "createScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-3" {
  statement_id = "AllowExecutionFromCloudWatch-3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-3.arn
}

# ################################################
# ###### create-scan-reg-files-1-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-4" {
  name = "create-scan-reg-files-1-Prod"
  schedule_expression = "cron(15 7 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-4" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-4.name
  input = jsonencode({
  "name": "createScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-4" {
  statement_id = "AllowExecutionFromCloudWatch-4"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-4.arn
}

# ################################################
# ###### create-scan-reg-files-2-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-5" {
  name = "create-scan-reg-files-2-Prod"
  schedule_expression = "cron(15 10 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-5" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-5.name
  input = jsonencode({
  "name": "createScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-5" {
  statement_id = "AllowExecutionFromCloudWatch-5"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-5.arn
}

# ################################################
# ###### initiate-mail-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-6" {
  name = "initiate-mail-Prod"
  schedule_expression = "cron(45 4 * * ? *)"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-6" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-6.name
  input = jsonencode({
  "name": "initiateMail"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-6" {
  statement_id = "AllowExecutionFromCloudWatch-6"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-6.arn
}

# ################################################
# ###### initiate-mail-1-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-7" {
  name = "initiate-mail-1-Prod"
  schedule_expression = "cron(45 7 * * ? *)"
  description = "Initiate Mail for Scan Registration Process @1:15pm"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-7" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-7.name
  input = jsonencode({
  "name": "initiateMail"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-7" {
  statement_id = "AllowExecutionFromCloudWatch-7"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-7.arn
}

# ################################################
# ###### initiate-mail-1-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-8" {
  name = "initiate-mail-2-Prod"
  schedule_expression = "cron(45 10 * * ? *)"
  description = "Initiate Mail for Scan Registration Process @4:15pm"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-8" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-8.name
  input = jsonencode({
  "name": "initiateMail"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-8" {
  statement_id = "AllowExecutionFromCloudWatch-8"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-8.arn
}

# ################################################
# ###### create-scan-images-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-9" {
  name = "create-scan-images-Prod"
  schedule_expression = "rate(15 minutes)"
  description = "create scan images every 15 mins"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-9" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-9.name
  input = jsonencode({
  "name": "processImageCropping"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-9" {
  statement_id = "AllowExecutionFromCloudWatch-9"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-9.arn
}

# ################################################
# ###### process-zip-creation-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-10" {
  name = "process-zip-creation-Prod"
  schedule_expression = "cron(30 3 * * ? *)"
  description = "Process zip creation at 9:00am"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-10" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-10.name
  input = jsonencode({
  "name": "processZipCreation"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-10" {
  statement_id = "AllowExecutionFromCloudWatch-10"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-10.arn
}

# ################################################
# ###### process-zip-creation-1-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-11" {
  name = "process-zip-creation-1-Prod"
  schedule_expression = "cron(30 6 * * ? *)"
  description = "process zip creation @12:00pm"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-11" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-11.name
  input = jsonencode({
  "name": "processZipCreation"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-11" {
  statement_id = "AllowExecutionFromCloudWatch-11"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-11.arn
}

# ################################################
# ###### process-zip-creation-2-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-12" {
  name = "process-zip-creation-2-Prod"
  schedule_expression = "cron(30 9 * * ? *)"
  description = "process zip creation @3:00pm"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-12" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-12.name
  input = jsonencode({
  "name": "processZipCreation"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-12" {
  statement_id = "AllowExecutionFromCloudWatch-12"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-12.arn
}

# ################################################
# ###### scanRegistrationMergeBank
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-13" {
  name = "scanRegistrationMergeBank"
  schedule_expression = "rate(10 minutes)"
  description = "At every @10mins"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-13" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-13.name
  input = jsonencode({
  "name": "scanRegistrationMergeBank"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-13" {
  statement_id = "AllowExecutionFromCloudWatch-13"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-13.arn
}

# ################################################
# ###### sentRegistration
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-14" {
  name = "sentRegistration"
  schedule_expression = "rate(15 minutes)"
  description = "At every @15mins"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-14" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-14.name
  input = jsonencode({
  "name": "sentRegistration"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-14" {
  statement_id = "AllowExecutionFromCloudWatch-14"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-14.arn
}

# ################################################
# ###### share-scan-reg-files-prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-15" {
  name = "share-scan-reg-files-prod"
  schedule_expression = "cron(30 4 * * ? *)"
  description = "Share Scan Registration Files and zip @10am"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-15" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-15.name
  input = jsonencode({
  "name": "shareScanRegistrationFiles"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-15" {
  statement_id = "AllowExecutionFromCloudWatch-15"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-15.arn
}

# ################################################
# ###### fetch-scan-reversal-files-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "ScanbaseRegistrationCrons-rule-16" {
  name = "fetch-scan-reversal-files-Prod"
  schedule_expression = "rate(35 minutes)"
  description = "fetch scan reversal files from indusind sftp every 35 mins"
}

resource "aws_cloudwatch_event_target" "ScanbaseRegistrationCrons_target-16" {
  arn = aws_lambda_function.ScanbaseRegistrationCrons-Prod.arn
  rule = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-16.name
  input = jsonencode({
  "name": "scanRegRevFilesFromSFTP"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ScanbaseRegistrationCrons_lambda-16" {
  statement_id = "AllowExecutionFromCloudWatch-16"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ScanbaseRegistrationCrons-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.ScanbaseRegistrationCrons-rule-16.arn
}