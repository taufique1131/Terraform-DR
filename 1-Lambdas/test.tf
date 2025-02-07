#############################################################
#############################################################
########################      Autopayment-API-Prod
#############################################################
#############################################################

variable "Autopayment-API-Prod" {
  type = object({
    name   = string
    runtime = string
    handler = string
  })
  default = {
    name   = "Autopayment-API-Prod"
    runtime = "nodejs18.x"
    handler = "src/handlers/index.systemXReportHandler"
  }
}

resource "aws_lambda_function" "Autopayment-API-Prod" {
    filename      = "${path.module}/Zip/${var.Autopayment-API-Prod["name"]}.zip"
    runtime       = var.Autopayment-API-Prod["runtime"]
    role          = aws_iam_role.Autopayment-API-Prod_role.arn
    handler       = var.Autopayment-API-Prod["handler"]
    function_name = var.Autopayment-API-Prod["name"]
    depends_on    = [aws_iam_role_policy_attachment.Autopayment-API-Prod_attachment]

    # Memory and Timeout Configuration
    memory_size = 512
    timeout     = 15

    # VPC Configuration
    vpc_config {
      subnet_ids         = ["subnet-xxxxxx", "subnet-yyyyyy"]
      security_group_ids = ["sg-xxxxxx"]
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
  name        = "Autopayment-API-Prod_policy"
  description = "Policy for Autopayment-API-Prod lambda"
  path        = "/"
  policy      = <<EOF
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
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "Autopayment-API-Prod_attachment" {
  role       = aws_iam_role.Autopayment-API-Prod_role.name
  policy_arn = aws_iam_policy.Autopayment-API-Prod_policy.arn
}
