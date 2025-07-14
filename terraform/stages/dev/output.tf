output "rds_endpoint" {
  value = app.rds_endpoint
}

output "rds_db_name" {
  value = app.rds_db_name
}

output "rds_username" {
  value = app.rds_username
}

output "rds_password" {
  value     = app.rds_password
  sensitive = true
}
