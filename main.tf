locals {
  config_data = jsondecode(file("./config.json"))
}

module "ec2" {
  source              = "./modules/ec2"
  ec2_instance_number = local.config_data.numberOfEc2Instance
}

module "lb"{
  source        = "./modules/lb"
  instance_id = module.ec2.instance_id
}