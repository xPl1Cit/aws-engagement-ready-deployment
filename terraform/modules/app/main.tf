module "vpc" {
  source  = "../network/vpc"
  project = var.project
  stage   = var.stage
  region = var.region

  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs = var.private_db_subnet_cidrs
}

module "database" {
    source = "../database"
    project = var.project
    stage   = var.stage

    private_db_subnet_ids = module.vpc.private_subnet_ids
    rds_sg_id = module.vpc.rds_sg_id
    db_instance_type = var.db_instance_type
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
}

module "key_pair" {
  source = "../compute/key-pair"
  project = var.project
  stage   = var.stage
}

module "kubernetes" {
  source = "../kubernetes/"
  cluster_name = "${var.project}-${var.stage}"
  project = var.project
  stage   = var.stage
  region = var.region

  ec2_instance_type = var.ec2_instance_type
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
}

module "bastion" {
  source = "../compute/bastion"
  project = var.project
  stage = var.stage

  bastion_security_group_id = module.vpc.bastion_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ami = var.bastion_ami
  instance_type = var.bastion_instance_type
  key_name = module.key_pair.key_name
}