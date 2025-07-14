output "bastion_sg_id" {
  value       = aws_security_group.bastion_sg.id
  description = "The ID of the security group for the Bastion host"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "The ID of the security group for the RDS DB"
}