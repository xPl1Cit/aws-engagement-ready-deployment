output "rds_endpoint" {
  value = module.app.rds_endpoint
}

output "rds_db_name" {
  value = module.app.rds_db_name
}

output "rds_username" {
  value = module.app.rds_username
}

output "rds_password" {
  value     = module.app.rds_password
  sensitive = true
}
