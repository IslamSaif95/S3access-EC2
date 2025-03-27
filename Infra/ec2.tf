data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}


resource "aws_instance" "myec2" {
    ami = data.aws_ami.this.id
    instance_type = var.instance_type
    iam_instance_profile = var.iam_instance_profile
    key_name      = aws_key_pair.deployer.key_name
    
    network_interface {
      network_interface_id = var.network_interface_id
      device_index = 0
    }
    
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/home/islam/.ssh/deployer-key.pub") 
}