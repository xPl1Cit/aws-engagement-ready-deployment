variable "project" {
  description = "The AWS Project Name."
  type        = string
}

variable "stage" {
  description = "The Deployment Stage."
  type        = string
}

variable "region" {
  description = "The Deployment Region."
  type        = string
}

variable "vpc_cidr" {
  description = "The VPC CIDR."
  type        = string
}

variable "availability_zones" {
  description = "The AWS availablity zones used for public subnets."
  type = list(string)
}

variable "public_subnet_cidrs" {
  description = "The CIDRs used for public subnets."
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "The CIDRs used for private subnets."
  type = list(string)
}