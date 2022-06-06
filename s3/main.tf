resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}"

  tags          = {
    Environment = "${var.bucket_environment}"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket       =  aws_s3_bucket.bucket.id
  acl          = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "pv-claim.yaml"
  acl          = "private"  # or can be "public-read"
  source       = "D:\\pv-claim.yaml"
  etag         = md5("D:\\pv-claim.yaml")
}

variable "named_folder" {
    type       = string
    default    = "mouritech-aws&azure-data"  
}

resource "aws_s3_bucket_object" "base_folder" {
    bucket     = aws_s3_bucket.bucket.id
    acl        = "private"
    key        = "${var.named_folder}/"
  content_type = "application/x-directory"
  
}