resource "aws_security_group" "mainSG" {
  name        = "mainSG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "SG for EC2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = toset([for p in var.port-list : tostring(p)])
  security_group_id = aws_security_group.mainSG.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = tonumber(each.value)
  ip_protocol       = "tcp"
  to_port           = tonumber(each.value)
}

resource "aws_vpc_security_group_ingress_rule" "allow_public_ipv4" {
  for_each          = toset([for p in var.port-list : tostring(p)])
  security_group_id = aws_security_group.mainSG.id
  cidr_ipv4         = "${aws_eip.foo.public_ip}/32"
  from_port         = tonumber(each.value)
  ip_protocol       = "tcp"
  to_port           = tonumber(each.value)
}

resource "aws_vpc_security_group_ingress_rule" "allow_default_ipv4" {
  for_each          = toset([for p in var.port-list : tostring(p)])
  security_group_id = aws_security_group.mainSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = tonumber(each.value)
  ip_protocol       = "tcp"
  to_port           = tonumber(each.value)
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.mainSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

