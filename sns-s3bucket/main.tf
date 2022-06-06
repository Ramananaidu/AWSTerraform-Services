resource "aws_sns_topic" "topic" {
  name = "s3-event-notification-topic"

  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[{
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:s3-event-notification-topic",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.bucket.arn}"}
        }
    }]
}
POLICY
}

resource "aws_s3_bucket" "bucket" {
  bucket = "sample-bucket-for-alerts"
}

resource "aws_s3_bucket_object" "object" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "pv-claim.yaml"
  acl          = "private"  # or can be "public-read"
  source       = "D:\\pv-claim.yaml"
  etag         = md5("D:\\pv-claim.yaml")
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*","s3:ObjectRemoved:*","s3:ObjectRestore:*"]
    #filter_suffix = ".png,.txt,.jpg"
  }
}

resource "aws_sns_topic_subscription" "user_updates_sns_target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "naidualamuru@gmail.com"
}
