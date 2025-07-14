module "app_vpc" {
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

  bastion_security_group_id = module.app_vpc.bastion_sg_id
  public_subnet_ids = module.app_vpc.public_subnet_ids
  ami = var.bastion_ami
  instance_type = var.bastion_instance_type
  key_name = module.key_pair.key_name
}