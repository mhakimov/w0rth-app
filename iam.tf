data "aws_iam_policy_document" "website_policy" {
version = "2012-10-17"
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    resources = [
       "arn:aws:s3:::${var.domain_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "marketing-policy" {
version = "2012-10-17"
  statement  {
    sid = "AllowUserToSeeBucketListInTheConsole"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
        "*"
    ]
  }
    statement  {
    sid = "AllowS3UploadActionInFolder"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.domain_name}/news/*"
    ]
  }
  
}

data "aws_iam_policy_document" "full-access-to-bucket" {
version = "2012-10-17"
statement  {
    sid = "AllowUserToSeeBucketListInTheConsole"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning"
    ]
    resources = [
        "*"
    ]
  }
  statement  {
    sid = "AllowUserAllActionsInBucket"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
        "arn:aws:s3:::${var.domain_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "update-people" {
version = "2012-10-17"
statement  {
    sid = "AllowUserToSeeBucketListInTheConsole"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]
    resources = [
        "*"
    ]
  }
    statement  {
    sid = "AllowUserUpdatePeopleFile"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
       "arn:aws:s3:::${var.domain_name}/people.html"
    ]
  }
}






