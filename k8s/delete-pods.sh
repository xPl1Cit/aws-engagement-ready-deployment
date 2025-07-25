#!/bin/bash

# Input arguments
REGION="${1:-us-east-1}"
VERSION="${2:-latest}"
DEPLOYMENT_COLOR="${3:-blue}"
ENVIRONMENT="${4:-test}"

echo "Using region: $REGION"
echo "Using image version: $VERSION"

# Get AWS Account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
if [ -z "$ACCOUNT_ID" ]; then
  echo "Failed to retrieve AWS account ID."
  exit 1
fi
echo "AWS Account ID: $ACCOUNT_ID"

# Script and template paths
SCRIPT_DIR=$(dirname "$(realpath "$0")")
ANGULAR_TEMPLATE="$SCRIPT_DIR/deployment/angular-deployment-template.yaml"
ANGULAR_CONFIG="$SCRIPT_DIR/deployment/angular-deployment.yaml"
CART_TEMPLATE="$SCRIPT_DIR/deployment/cart-deployment-template.yaml"
CART_CONFIG="$SCRIPT_DIR/deployment/cart-deployment.yaml"
PRODUCT_TEMPLATE="$SCRIPT_DIR/deployment/product-deployment-template.yaml"
PRODUCT_CONFIG="$SCRIPT_DIR/deployment/product-deployment.yaml"

# Replace placeholders in deployment templates
for TEMPLATE in "$ANGULAR_TEMPLATE" "$CART_TEMPLATE" "$PRODUCT_TEMPLATE"; do
  TARGET_FILE="${TEMPLATE/-template/}"
  cp "$TEMPLATE" "$TARGET_FILE"
  sed -i "s|{{REGION}}|$REGION|g" "$TARGET_FILE"
  sed -i "s|{{AWS_ACCOUNT_ID}}|$ACCOUNT_ID|g" "$TARGET_FILE"
  sed -i "s|{{VERSION_TAG}}|$VERSION|g" "$TARGET_FILE"
  sed -i "s|{{DEPLOYMENT_COLOR}}|$DEPLOYMENT_COLOR|g" "$TARGET_FILE"
  sed -i "s|{{ENVIRONMENT}}|$ENVIRONMENT|g" "$TARGET_FILE"
done

# Deploy both pods
echo "Deleting Angular and Spring pods..."
kubectl delete -f "$ANGULAR_CONFIG"
kubectl delete -f "$CART_CONFIG"
kubectl delete -f "$PRODUCT_CONFIG"

# Clean up deployment configs
rm "$ANGULAR_CONFIG" "$CART_CONFIG" "$PRODUCT_CONFIG"

echo "Pod Deletion complete."
