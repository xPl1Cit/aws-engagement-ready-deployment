output "rds_endpoint" {
  value = module.database.rds_endpoint
  description = "The RDS Postgres endpoint for the Product DB"
}

output "rds_db_name" {
  value = module.database.rds_db_name
}

output "rds_username" {
  value = module.database.rds_username
}

output "rds_password" {
  value     = module.database.rds_password
  sensitive = true
}
