module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "eks-vpc-${var.project}-${var.stage}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway      = true
  single_nat_gateway      = true
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.project}-${var.stage}" = "shared"
  }
}

module "security_groups" {
  source = "../security_groups"
  project = var.project
  stage = var.stage
  vpc_id = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
}