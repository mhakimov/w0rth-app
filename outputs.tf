
output "endpoint" {
  value = "${aws_s3_bucket.b1.id}.${aws_s3_bucket.b1.website_domain}"
}

output "cloudfront-distribution" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}