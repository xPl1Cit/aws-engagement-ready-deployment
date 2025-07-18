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

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "The ID of the VPC's private subnets"
  type = list(string)
}