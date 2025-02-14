#################################
######## S3 buckets and data upload
#################################

resource "aws_s3_bucket" "systemx-hyd-dr-ui" {
  bucket = "systemx-hyd-dr-ui"
  force_destroy = true 
}

# resource "aws_s3_bucket_policy" "allow_access_from_cf_hyd_region" {
#   bucket = aws_s3_bucket.systemx-hyd-dr-ui.id
#   policy = data.aws_iam_policy_document.allow_access_from_cf_hyd_region.json
# }

# data "aws_iam_policy_document" "allow_access_from_cf_hyd_region" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["123456789012"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       aws_s3_bucket.systemx-hyd-dr-ui.arn,
#       "${aws_s3_bucket.systemx-hyd-dr-ui.arn}/*",
#     ]
#   }
# }

resource "aws_s3_bucket_public_access_block" "systemx-hyd-dr-ui-bucket" {
  bucket = aws_s3_bucket.systemx-hyd-dr-ui.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_website_configuration" "systemx-hyd-dr-ui" {
#     bucket = aws_s3_bucket.systemx-hyd-dr-ui.id
    
#     index_document {
#     suffix = "index.html"
#   }
#     error_document {
#     key = "error.html"
#   }
  
# }

resource "aws_s3_bucket_cors_configuration" "systemx-hyd-dr-ui" {
  bucket = aws_s3_bucket.systemx-hyd-dr-ui.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST" , "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }

}