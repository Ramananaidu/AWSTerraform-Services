variable "autoscalingkey_pair" {
    default = "Autoscaling_key"
    type = string
    description = "This is about Autoscaling key pair name"
  
}
variable "custom-launch-config" {
    default = "custom-launch-config"
    type = string
  
}
variable "autoscalingname" {
    default = "AutoscalingEC2-Machine"
    type = string
  
}
variable "cpu-policy" {
    default = "AutoscalingEC2policy"
    type = string
  
}
variable "cpu-alarm" {
    default = "Custom-CPU-Alarm"
    type = string
  
}
variable "cpu-down-policy" {
    default = "DownScalingEC2policy"
    type = string
  
}
variable "cpu-alarm-scaledown" {
    default = "Custom-CPU-Alarm-scaledown"
    type = string
  
}
variable "public_key_path" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMLhgOEA5gMVT0q0uBLbIPoYUecws0kmQ5Tx7qOZH1geTACdYmAVxVixXNkhqI4SrIilZPkvUAN1I9GQEbm8mu8+mPo8sfZwPnNOZxssn5Pr0bvYvfO3SgSBKAHBKRRjvvaJgh6K0NDlDfdiAMdxsJ0qu22nblZ9ApPdvDfD1wSu8muAcAfh8vU+Gv9ln0fS6IWi3nrfhBNBnhKB7OIvC7D7w1hE23rq/eGnw8AMyWSwrdhWjiyaDI06K7+6EUGWFkyzn71TdJ4BL8aKayLcG8vjRtQIzQ8ycaOg7ghC2pUqzomByiu24O37b4iTXbEvCUW/gLSNHSdU5tdvW3u+fuy/Yg90PRBSWAXyLffOYmWUlR3n1EtzbT+RQuEydj5Pkyd3clYRr2SVyM8zbRRkps1IGe5Zimkp4aK4nYhPHwnJXl5L4nF8wgXwiRJ0mNFG1yLbzZKdCQfuLoYSie6hg6ci1jD2B+1Y+q+FriXXvbFiczBdBd522QeY0xu65phkM="
    type = string
  
}
variable "key_name" {
    default="my-key"
}
variable "PATH_TO_PUBLIC_KEY" {
    default = "mykey.pub"
}