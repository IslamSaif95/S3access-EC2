variable "instance_type" {}

variable "vpc_cidr" {}

variable "port-list" {
  type = list(number)
}

variable "region" {
  type = string
}

