variable "project" {
  description = "The AWS Project Name."
  type        = string
}

variable "region" {
  description = "The AWS Region."
  type        = string
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
}

variable "vpc_cidr" {
  description = "The VPC CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "The AWS availablity zones used for public subnets."
  type = list(string)
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

variable "public_subnet_cidrs" {
  description = "The CIDRs used for public subnets."
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
  description = "The CIDRs used for private subnets."
  type = list(string)
  default = [ "10.0.5.0/24", "10.0.6.0/24" ]
}

variable "db_instance_type" {
  description = "The Database Instance Type to be launched."
  type        = string
  default = "db.t3.medium"
}

variable "db_name" {
  description = "The Default Database Name to be launched."
  type        = string
}

variable "db_username" {
  description = "The Database Username to be launched."
  type        = string
}

variable "db_password" {
  description = "The Database Password to be launched."
  type        = string
}

variable "ec2_instance_type" {
  description = "The EC2 Instance Type to be launched."
  type        = string
  default = "t2.small"
}

variable "bastion_instance_type" {
  description = "The Bastion EC2 Instance Type to be launched."
  type        = string
  default = "t2.micro"
}

variable "ami" {
  description = "The EC2 AMI to be launched."
  type        = string
  default = "ami-0e449927258d45bc4"
}

variable "bastion_ami" {
  description = "The Bastion EC2 AMI to be launched."
  type        = string
  default = "ami-0e449927258d45bc4"
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