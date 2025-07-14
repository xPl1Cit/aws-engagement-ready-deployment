output "db_endpoint" {
  value = aws_db_instance.wordpress.endpoint
  description = "The RDS MySQL endpoint for WordPress"
}

output "db_port" {
  value = aws_db_instance.wordpress.port
  description = "The RDS MySQL port"
}