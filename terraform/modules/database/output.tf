output "db_endpoint" {
  value = aws_db_instance.product.endpoint
  description = "The RDS Postgres endpoint for the Product DB"
}

output "db_port" {
  value = aws_db_instance.product.port
  description = "The RDS Postgres port"
}