variable "project" {
  description = "The AWS Project Name."
  type        = string
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
}

variable "db_name" {
  description = "The Default Database Name."
  type        = string
}

variable "db_username" {
  description = "The Default Database Username."
  type        = string
}

variable "db_password" {
  description = "The Default Database Username. Change later as needed"
  type        = string
}

variable "db_instance_type" {
  description = "The Database Instance Type."
  type        = string
}

variable "private_db_subnet_ids" {
  description = "The Subnet IDs for the Database to launch into."
  type        = list(string)
}

variable "rds_sg_id" {
  description = "The ID of the RDS security group."
  type        = string
}