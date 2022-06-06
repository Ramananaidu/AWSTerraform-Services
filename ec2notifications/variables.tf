variable "ec2-instance-ami" {
    default     = "ami-079b5e5b3971bd10d"
    description = "This is about ec2 Instance AMI ID"
    type        = string
  
}
variable "ec2-instance-name" {
    default     = "Application-instance"
    description = "This is about ec2 Instance AMI ID"
    type        = string
  
}
variable "ec2-instance-topic" {
    default     = "EC2InstanceNotifications"
    description = "This is about ec2 Instance Alert Name"
    type        = string
  
}
variable "ec2-protocol" {
    default     = "email"
    description = "This is about ec2 Instance Protocol Type"
    type        = string
  
}
variable "ec2-mailaddress" {
    default     = "naidualamuru@gmail.com"
    description = "This is about Email Address to get Notifications"
    type        = string
  
}
variable "target-id" {
    default     = "SendToSNS"
    description = "This is about ec2 target-ID"
    type        = string
  
}
variable "ec2-scaling-events" {
    default     = "capture-ec2-scaling-events"
    description = "This is about ec2 scaling event name"
    type        = string
  
}
variable "ec2-size-type" {
    default     = "t2.micro"
    description = "This is about ec2 scaling event name"
    type        = string
  
}