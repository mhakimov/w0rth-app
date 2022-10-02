provider "aws" {
  region  = var.region
}


# Creates bucket
resource "aws_s3_bucket" "b1" {
  bucket = var.domain_name
}


# makes bucket public
resource "aws_s3_bucket_policy" "b1-policy" {
    bucket = aws_s3_bucket.b1.id
    policy = data.aws_iam_policy_document.website_policy.json
}

resource "aws_s3_object" "objects" {
  for_each = fileset("${path.module}/tech-test", "**/*.html")
  bucket = aws_s3_bucket.b1.id
  key    = each.value
  source = "${path.module}/tech-test/${each.value}"
  content_type = "text/html" 
}

# enables website hosting. 
resource "aws_s3_bucket_website_configuration" "b1-config" {
  bucket = aws_s3_bucket.b1.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# web distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.b1.bucket_regional_domain_name
    origin_id   = var.domain_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  custom_error_response {
    error_code = "404"
    response_page_path = "/error.html"
    response_code = "404"
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.domain_name
    
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


# _________Marketing_____________

# Creates users
resource "aws_iam_user" "m-users" {
  count = length(var.marketing-users)
  name = var.marketing-users[count.index]
}


resource "aws_iam_group" "marketing-group" {
  name = "Marketing"
}

resource "aws_iam_group_membership" "marketing-group-membership" {
  name = "marketing-group-membership"
  count = length(aws_iam_user.m-users)
  users = [
    aws_iam_user.m-users[0].name,
    aws_iam_user.m-users[1].name
  ]
  group = aws_iam_group.marketing-group.name
}

resource "aws_iam_group_policy" "marketing-group-policy" {
  name  = "MarketingS3Policy"
  group = aws_iam_group.marketing-group.name
  policy = data.aws_iam_policy_document.marketing-policy.json
}


# ________Content Editor________________
resource "aws_iam_user" "bobby" {
  name = "Bobby"
}

resource "aws_iam_group" "content-editors" {
  name = "ContentEditors"
}

resource "aws_iam_group_membership" "content-editors-group-membership" {
  name = "content-editors-membership"
  users = [
    aws_iam_user.bobby.name,
  ]
  group = aws_iam_group.content-editors.name
}

resource "aws_iam_group_policy" "content-editors-group-policy" {
  name  = "ContentEditorsS3Policy"
  group = aws_iam_group.content-editors.name
  policy = data.aws_iam_policy_document.full-access-to-bucket.json
}


# __________HR______________________________
resource "aws_iam_user" "charlie" {
  name = "Charlie"
}

resource "aws_iam_group" "hr" {
  name = "HR"
}

resource "aws_iam_group_membership" "hr-group-membership" {
  name = "hr-membership"
  users = [
    aws_iam_user.charlie.name,
  ]
  group = aws_iam_group.hr.name
}

resource "aws_iam_group_policy" "hr-group-policy" {
  name  = "HRS3Policy"
  group = aws_iam_group.hr.name
  policy = data.aws_iam_policy_document.update-people.json
}
