output "s3_bucket_arn" {
  value = [for i in aws_s3_bucket.exo_s3_bucket:i.arn]
}