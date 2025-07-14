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
  default     = "dev"
}

variable "ec2_instance_type" {
  description = "The EC2 Instance Type to be launched."
  type        = string
  default = "t2.medium"
}

variable "desired_capacity" {
  description = "The Number of EC2 instances to be launched by default."
  type        = number
  default = 1

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

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "aws-training-al-dev"
}