variable "instance_type" {}

variable "vpc_cidr" {}


variable "iam_instance_profile" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "network_interface_id" {
  type = string
}

variable "security_group_id" {
  type = string
}