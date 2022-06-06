# resource "tls_private_key" "autoscaling_key_pair_name" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
resource "aws_key_pair" "autoscaling_key_pair" {
    key_name = "${var.autoscalingkey_pair}"
    public_key = "${var.public_key_path}"
}
resource "aws_launch_configuration" "custom-launch-config" {
  name = "${var.custom-launch-config}"
  image_id = "ami-0756a1c858554433e"
  instance_type = "t2.micro"
  key_name = aws_key_pair.autoscaling_key_pair.key_name
}
resource "aws_autoscaling_group" "custom-group-autocaling" {
  name                      = "${var.autoscalingname}"
  vpc_zone_identifier = ["subnet-024ccec259b769a61"]
  launch_configuration = aws_launch_configuration.custom-launch-config.name
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  tag {
      key = "Name"
      value = "Autoscaling-EC2-Instance"
      propagate_at_launch = true
  }
  }
  resource "aws_autoscaling_policy" "custom-cpu-policy" {
  name                   = "${var.cpu-policy}"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.custom-group-autocaling.name
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm" {
  alarm_name                = "${var.cpu-alarm}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "20"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  dimensions = {
    "AutoScalingGroupName":aws_autoscaling_group.custom-group-autocaling.name
  }
  actions_enabled = true
  alarm_actions =[aws_autoscaling_policy.custom-cpu-policy.arn]
}
resource "aws_autoscaling_policy" "custom-cpu-scaledown-policy" {
  name                   = "${var.cpu-policy}"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.custom-group-autocaling.name
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm-scaledown" {
  alarm_name                = "${var.cpu-alarm}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  dimensions = {
    "AutoScalingGroupName":aws_autoscaling_group.custom-group-autocaling.name
  }
  actions_enabled = true
  alarm_actions =[aws_autoscaling_policy.custom-cpu-policy.arn]
}