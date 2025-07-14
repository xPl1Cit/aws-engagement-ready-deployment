output "rds_endpoint" {
  value = aws_db_instance.product.endpoint
  description = "The RDS Postgres endpoint for the Product DB"
}

output "db_port" {
  value = aws_db_instance.product.port
  description = "The RDS Postgres port"
}

output "rds_db_name" {
  value = aws_db_instance.product.db_name
}

output "rds_username" {
  value = aws_db_instance.product.username
}

output "rds_password" {
  value     = aws_db_instance.product.password
  sensitive = true
}
