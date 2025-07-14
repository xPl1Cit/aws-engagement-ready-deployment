variable "project" {
  description = "The AWS Project Name."
  type        = string
  default     = "aws-training-al"
}

variable "region" {
  description = "The AWS Region."
  type        = string
  default     = "us-east-1"
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
  default     = "test"
}

variable "db_instance_type" {
  description = "The Database Instance Type to be launched."
  type        = string
  default = "db.t3.medium"
}

variable "db_name" {
  description = "The Default Database Name to be launched."
  type        = string
  default = "wordpress"
}

variable "db_username" {
  description = "The Database Username to be launched."
  type        = string
  default = "admin"
}

variable "db_password" {
  description = "The Database Password to be launched."
  type        = string
  default = "password"
}

variable "ec2_instance_type" {
  description = "The EC2 Instance Type to be launched."
  type        = string
  default = "t2.small"
}

variable "desired_capacity" {
  description = "The Number of EC2 instances to be launched by default."
  type        = number
  default = 2

  validation {
    condition = (
      var.desired_capacity >= var.min_size &&
      var.desired_capacity <= var.max_size
    )
    error_message = "The desired_capacity must be between min_size and max_size."
  }
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