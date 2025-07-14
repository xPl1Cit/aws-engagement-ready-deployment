#!/bin/bash

set -euo pipefail

# Check if region is passed as an argument
if [ -z "$1" ]; then
  echo "Environment not provided. Using default environment: test"
  ENV="test"  # Default to test if no environment is provided
else
  ENV=$1
  echo "Using environment: $ENV"
fi

cd "./terraform/stages/$ENV" || {
  echo "❌ Directory './terraform/stages/$ENV' does not exist."
  exit 1
}

# ---- Required variables ----
AWS_REGION="${AWS_REGION:-us-east-1}"           # default region if not passed
EKS_CLUSTER_NAME="${EKS_CLUSTER_NAME:-aws-final-al-$ENV}"  # default cluster name if not passed

# ---- Setup kubectl config for the cluster ----
echo "🔧 Setting up kubectl for cluster '$EKS_CLUSTER_NAME' in region '$AWS_REGION'..."
aws eks update-kubeconfig --name "$EKS_CLUSTER_NAME" --region "$AWS_REGION"

# ---- Read Terraform outputs from current directory ----
echo "📦 Reading Terraform outputs from $(pwd)..."
DB_HOST=$(terraform output -raw rds_endpoint)
DB_NAME=$(terraform output -raw rds_db_name)
DB_USER=$(terraform output -raw rds_username)
DB_PASSWORD=$(terraform output -raw rds_password)

# ---- Create Kubernetes Secret ----
echo "🔐 Creating Kubernetes secret 'db-secret'..."
kubectl create secret generic db-secret \
  --from-literal=DB_HOST="$DB_HOST" \
  --from-literal=DB_NAME="$DB_NAME" \
  --from-literal=DB_USER="$DB_USER" \
  --from-literal=DB_PASSWORD="$DB_PASSWORD" \
  -n default

echo "✅ Kubernetes secret 'db-secret' created successfully."
