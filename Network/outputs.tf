output "iam_instance_profile" {
  value = aws_iam_instance_profile.EC2-S3-Access.name
}

output "security_group_id" {
  value = aws_security_group.mainSG.id
}

output "vpc" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "network_interface_id" {
  value = aws_network_interface.foo.id
}

output "aws_eip" {
  value = aws_eip.foo.public_ip
}