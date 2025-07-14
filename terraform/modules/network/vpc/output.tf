output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
  description = "The IDs of the public subnets"
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
  description = "The IDs of the private subnets"
}

output "bastion_sg_id" {
  value       = module.security_groups.bastion_sg_id
  description = "The ID of the security group for the Bastion host"
}

output "rds_sg_id" {
  value       = module.security_groups.rds_sg_id
  description = "The ID of the security group for the RDS DB"
}