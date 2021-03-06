resource "aws_cloudwatch_event_target" "yada" {
  target_id = "StopInstance"
  rule      = aws_cloudwatch_event_rule.console.name
  arn       = aws_kinesis_stream.test_stream.arn

  
  run_command_targets {
    key    = "InstanceIds"
    values = ["i-0d706c4d0d53d7d8d"]
  }
}

resource "aws_cloudwatch_event_rule" "console" {
  name        = "capture-ec2-scaling-events"
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful",
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful"
  ]
}
PATTERN
}

resource "aws_kinesis_stream" "test_stream" {
  name        = "terraform-kinesis-test"
  shard_count = 1
}