#################################
######## CF for Hyderabad UI buckets
#################################

resource "aws_cloudfront_origin_access_control" "hyd_dr_distribution" {
  name                              = "hyd_dr_distribution_oac"
  description                       = "hyd_dr_distribution_policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  hyd_s3_origin_id = "hyd_s3_origin"
}
resource "aws_cloudfront_distribution" "hyd_dr_distribution" {
  origin {
    domain_name              = aws_s3_bucket.systemx-hyd-dr-ui.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.hyd_dr_distribution.id
    origin_id                = local.hyd_s3_origin_id
  }

  enabled             = true
  comment             = "Hyd Systemx UI"
  default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

  aliases = [ "apps55.tatacapital.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.hyd_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}