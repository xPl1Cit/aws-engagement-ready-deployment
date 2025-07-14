module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"
  subnet_ids      = var.private_subnet_ids
  vpc_id          = var.vpc_id

  cluster_endpoint_public_access = true
  enable_irsa                    = true

  cluster_addons = {
    coredns                         = { most_recent = true }
    vpc-cni                         = { most_recent = true }
    kube-proxy                      = { most_recent = true }
    aws-ebs-csi-driver              = { most_recent = true }
    amazon-cloudwatch-observability = { most_recent = true }
  }

  cloudwatch_log_group_retention_in_days = 7
  cluster_enabled_log_types = [
    "api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  eks_managed_node_groups = {
    spot_nodes = {
      instance_types      = [var.ec2_instance_type]
      desired_size        = var.desired_capacity
      min_size            = var.min_size
      max_size            = var.max_size
      capacity_type       = "SPOT"
      private_networking  = true
      volume_encrypted    = true

      iam_role_addon_policies = {
        alb_ingress = true
        cloudwatch  = true
        auto_scaler = true
        ebs         = true
        xray        = true
      }
    }
  }

  fargate_profiles = {
    on-fargate = {
      selectors = [{
        namespace = "on-fargate"
      }]
    }

    myprofile = {
      selectors = [{
        namespace = "prod"
        labels = {
          stack = "frontend"
        }
      }]
    }
  }

  tags = {
    Environment = var.stage
    Project     = var.project
  }
}
