locals {
  config_data = jsondecode(file("./config.json"))
}

module "ec2" {
  source              = "./modules/ec2"
  ec2_instance_number = local.config_data.numberOfEc2Instance
  profile = module.s3_roles.ec2_profile_name
}


module "lb" {
  source      = "./modules/lb"
  instance_id = module.ec2.instance_id
  count       = local.config_data.numberOfEc2Instance > 1 ? 1 : 0
}

module "secrets_manager" {
  source = "./modules/secrets_manager"
}


module "rds" {
  source = "./modules/rds"

  rds_credential = {
    username : module.secrets_manager.db_password.username,
    password : module.secrets_manager.db_password.password
  }
  depends_on = [module.secrets_manager]
}

module "waf" {
  source = "./modules/waf"
  lb_arn = module.lb[0].lb_arn
}

module "s3"{
  source = "./modules/s3"
  bucket_count = local.config_data.bucketCount
}

module "s3_roles" {
  source = "./modules/roles/s3_role"
  s3_arn = module.s3.s3_bucket_arn
}