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
      }
    ]
    }
    EOF
    }
 
resource "aws_iam_role_policy_attachment" "EnachAdoptionReports-Prod_attachment" {
 role        = aws_iam_role.EnachAdoptionReports-Prod_role.name
 policy_arn  = aws_iam_policy.EnachAdoptionReports-Prod_policy.arn
}


