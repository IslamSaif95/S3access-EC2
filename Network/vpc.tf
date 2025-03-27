resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

   tags = {
    Name = "My-Subnet"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.0.100"]
  security_groups = [aws_security_group.mainSG.id]  
}

resource "aws_route_table" "public" { 
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_eip" "foo" {
  domain = "vpc"

  tags = {
    Name = "EIP for Network Interface"
  }
}

resource "aws_eip_association" "foo" {
  network_interface_id = aws_network_interface.foo.id
  allocation_id        = aws_eip.foo.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
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