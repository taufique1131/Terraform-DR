

# #############################################################
#############################################################
########################CronLambdaInvocation-Prod
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

# ################################################
# ###### MicroService_Prod_TPSL_Transaction_Status
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-1" {
  name = "MicroService_Prod_TPSL_Transaction_Status"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-1" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-1.name
  input = jsonencode({
  "name": "TPSL_TRANSACTION_STATUS"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-1" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-1.arn
}

# ################################################
# ###### MicroService_Prod_Swap_Mandat_Block_File_Generation
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-2" {
  name = "MicroService_Prod_Swap_Mandat_Block_File_Generation"
  schedule_expression = "cron(30 18 * * ? *)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-2" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-2.name
  input = jsonencode({
  "name": "SWAP_MND_BLK"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-2" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-2.arn
}

# ################################################
# ###### MicroService_Prod_Nupay_Transaction_Status
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-3" {
  name = "MicroService_Prod_Nupay_Transaction_Status"
  schedule_expression = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-3" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-3.name
  input = jsonencode({
  "name": "NUPAY_TRANSACTION_STATUS"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-3" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-3.arn
}

# ################################################
# ###### MicroService_Prod_Nupay_Transaction_Status
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-4" {
  name = "MicroService_Prod_Nupay_Transaction_Status"
  schedule_expression = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-4" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-4.name
  input = jsonencode({
  "name": "NUPAY_TRANSACTION_STATUS"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-4" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-4.arn
}

# ################################################
# ###### MicroService_Prod_Bitly_SMS_Status
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-4" {
  name = "MicroService_Prod_Bitly_SMS_Status"
  schedule_expression = "rate(45 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-4" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-4.name
  input = jsonencode({
  "name": "BITLY_USAGE_LIMIT"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-4" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-4.arn
}

# ################################################
# ###### SFDC_API_LOS_UPDATE_PROD
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-5" {
  name = "SFDC_API_LOS_UPDATE_PROD"
  schedule_expression = "cron(30 13 * * ? *)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-5" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-5.name
  input = jsonencode({
  "name": "SFDC_API_LOS_UPDATE"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-5" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-5.arn
}

# ################################################
# ###### Open_mandate_Limit_transfer_Prod
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-6" {
  name = "Open_mandate_Limit_transfer_Prod"
  schedule_expression = "cron(00 19 * * ? *)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-6" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-6.name
  input = jsonencode({
  "name": "OPEN_MANDATE_LIMIT_TRANSFER"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-6" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-6.arn
}

# ################################################
# ###### ACCOUNT_VALIDATION_BENE_UPDATE-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-7" {
  name = "ACCOUNT_VALIDATION_BENE_UPDATE-Prod"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-7" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-7.name
  input = jsonencode({
  "name": "ACCOUNT_VALIDATION_BENE_UPDATE"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-7" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-7.arn
}

# ################################################
# ###### MicroService_UMRN_MISMATCH
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-8" {
  name = "MicroService_UMRN_MISMATCH"
  schedule_expression = "rate(45 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-8" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-8.name
  input = jsonencode({
  "name": "MISMATCH_UMRN"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-8" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-8.arn
}

# ################################################
# ###### MicroService_AutoAmountReductionCounter_Prod
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-9" {
  name = "MicroService_AutoAmountReductionCounter_Prod"
  schedule_expression = "cron(15 19 * * ? *)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-9" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-9.name
  input = jsonencode({
  "name": "MAX_AMOUNT_DEDUCTION"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-9" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-9.arn
}

# ################################################
# ###### RETRY_ENQUIRY_ICICI_FAILURE_CASES_Prod
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-10" {
  name = "RETRY_ENQUIRY_ICICI_FAILURE_CASES_Prod"
  schedule_expression = "rate(3 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-10" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-10.name
  input = jsonencode({
  "name": "RETRY_ICICI_FAILURE_CASES"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-10" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-10.arn
}

# ################################################
# ###### ICICI_OLDER_CASES_MARK_PROD
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-11" {
  name = "ICICI_OLDER_CASES_MARK_PROD"
  schedule_expression = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-11" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-11.name
  input = jsonencode({
  "name": "ICICI_OLDER_CASES_MARK"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-11" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-11.arn
}

# ################################################
# ###### LENDINGKART_UTR_CALLBACK-Prod
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-12" {
  name = "LENDINGKART_UTR_CALLBACK-Prod"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-12" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-12.name
  input = jsonencode({
  "name": "LENDINGKART_UTR"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-12" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-12.arn
}

# ################################################
# ###### UTR_UPDATE_FINNONE_END_PROD
# ################################################

resource "aws_cloudwatch_event_rule" "CronLambdaInvocation-rule-13" {
  name = "UTR_UPDATE_FINNONE_END_PROD"
  schedule_expression = "rate(15 minutes)"
}

resource "aws_cloudwatch_event_target" "CronLambdaInvocation_target-13" {
  arn = aws_lambda_function.CronLambdaInvocation-Prod.arn
  rule = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-13.name
  input = jsonencode({
  "name": "UTR_UPDATE_FINNONE_END"
})
}

resource "aws_lambda_permission" "allow_cloudwatch_to_CronLambdaInvocation_lambda-13" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CronLambdaInvocation-Prod.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.CronLambdaInvocation-rule-13.arn
}