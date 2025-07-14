output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
  description = "The IDs of the public subnets"
}

output "private_db_subnet_ids" {
  value = module.subnets.private_db_subnet_ids
  description = "The IDs of the private db subnets"
}

output "private_app_subnet_ids" {
  value = module.subnets.private_app_subnet_ids
  description = "The IDs of the private app subnets"
}

output "bastion_sg_id" {
  value       = module.security_groups.bastion_sg_id
  description = "The ID of the security group for the Bastion host"
}

output "rds_sg_id" {
  value       = module.security_groups.rds_sg_id
  description = "The ID of the security group for the RDS DB"
}