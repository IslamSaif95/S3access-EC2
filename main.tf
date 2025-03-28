terraform {
  backend "s3" {
    bucket = "islamsaifs3bucket1995forstatefile"
    key    = "Terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

module "Network" {
  source    = "./Network"
  vpc_cidr  = var.vpc_cidr
  port-list = var.port-list
}

module "Infra" {
  source               = "./Infra"
  instance_type        = var.instance_type
  vpc_cidr             = var.vpc_cidr
  iam_instance_profile = module.Network.iam_instance_profile
  subnet_id            = module.Network.subnet_id
  network_interface_id = module.Network.network_interface_id
  security_group_id    = module.Network.security_group_id
}

