module "wordpress" {
  source  = "../../modules/wordpress"
  project = var.project
  stage   = var.stage
  region = var.region
  
  db_instance_type = var.db_instance_type
  db_name = var.db_name
  db_username = var.db_password
  
  ec2_instance_type = var.ec2_instance_type
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size
}