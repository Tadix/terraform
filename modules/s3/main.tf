resource "aws_s3_bucket" "exo_s3_bucket" {
count = var.bucket_count
bucket = "exo-s3-bucket-${count.index}"
tags = {
  Name        = "exo_s3_bucket"
  Environment = "Production"
}
}