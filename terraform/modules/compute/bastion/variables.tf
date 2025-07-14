variable "project" {
  description = "The AWS Project Name."
  type        = string
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
}

variable "ami" {
  description = "The EC2 ami to be launched."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type to be launched."
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets."
  type        = list(string)
}

variable "bastion_security_group_id" {
  description = "The Bastion Security Group ID."
  type        = string
}

variable "key_name" {
  description = "The EC2 instance key name to be used."
  type        = string
}