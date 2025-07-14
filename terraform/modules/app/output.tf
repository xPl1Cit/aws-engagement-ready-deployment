output "rds_endpoint" {
  value = database.rds_endpoint
  description = "The RDS Postgres endpoint for the Product DB"
}

output "rds_db_name" {
  value = database.rds_db_name
}

output "rds_username" {
  value = database.rds_username
}

output "rds_password" {
  value     = database.rds_password
  sensitive = true
}
