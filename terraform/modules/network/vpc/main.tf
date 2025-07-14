module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "eks-vpc-${var.project}-${var.stage}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_app_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.project}-${var.stage}" = "shared"
  }
}
