resource "aws_cloudwatch_event_rule" "console" {
  name        = "${var.ec2-scaling-events}"

  event_pattern = <<PATTERN
{
  "source": ["aws.ec2"],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful",
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful",
    "EC2 Spot Interruption Warning",
    "EC2 Instance State-change Notification"
  ]
}
PATTERN
}

resource "aws_instance" "ec2_instance" {
  ami           = "${var.ec2-instance-ami}"
  instance_type = "${var.ec2-size-type}"

  tags = {
    Name = "${var.ec2-instance-name}"
  }
}

resource "aws_sns_topic" "ec2_topic" {
  name            = "${var.ec2-instance-topic}"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}
resource "aws_sns_topic_subscription" "ec2_subcription" {
    topic_arn = aws_sns_topic.ec2_topic.arn
    protocol = "${var.ec2-protocol}"
    endpoint = "${var.ec2-mailaddress}"
  
}

resource "aws_cloudwatch_event_target" "ec2_instance_trigger" {
  rule      = aws_cloudwatch_event_rule.console.name
  target_id = "${var.target-id}"
  arn       = aws_sns_topic.ec2_topic.arn
  input_transformer {
    input_paths = {
      account_id          = "$.account",
      time                = "$.time",
      region              = "$.region",
      title               = "$.detail-type",
      instance-id         = "$.detail.instance-id",
      action              = "$.detail.instance-action"
    }
    input_template = "\" <title>: <time> - EC2 Instance (<instance-id>) will <action> on account <account_id> in the AWS Region <region>.\""
}
  
}
resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.ec2_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.ec2_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}