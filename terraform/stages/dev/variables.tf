variable "project" {
  description = "The AWS Project Name."
  type        = string
  default     = "aws-final-al"
}

variable "region" {
  description = "The AWS Region."
  type        = string
  default     = "us-east-1"
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
  default     = "dev"
}

variable "db_instance_type" {
  description = "The Database Instance Type to be launched."
  type        = string
  default = "db.t3.medium"
}

variable "db_name" {
  description = "The Default Database Name to be launched."
  type        = string
  default = "products"
}

variable "db_username" {
  description = "The Database Username to be launched."
  type        = string
  default = "andreasadmin"
}

variable "db_password" {
  description = "The Database Password to be launched."
  type        = string
  default = "PleaseChange123!"
}

variable "ec2_instance_type" {
  description = "The EC2 Instance Type to be launched."
  type        = string
  default = "t2.medium"
}

variable "desired_capacity" {
  description = "The Number of EC2 instances to be launched by default."
  type        = number
  default = 3
}

variable "min_size" {
  description = "The Minimum number of EC2 instances to be launched."
  type        = number
  default = 1
}

variable "max_size" {
  description = "The Maximum number of EC2 instances to be launched."
  type        = number
  default = 5
}