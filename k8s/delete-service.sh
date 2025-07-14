#!/bin/bash

# Input arguments
VERSION="${1:-latest}"
DEPLOYMENT_COLOR="${2:-blue}"

echo "Using image version: $VERSION"
echo "Deleting $DEPLOYMENT_COLOR version"

# Script and template paths
SCRIPT_DIR=$(dirname "$(realpath "$0")")
CART_TEMPLATE="$SCRIPT_DIR/deployment/cart-service-template.yaml"
CART_CONFIG="$SCRIPT_DIR/deployment/cart-service.yaml"
PRODUCT_TEMPLATE="$SCRIPT_DIR/deployment/product-service-template.yaml"
PRODUCT_CONFIG="$SCRIPT_DIR/deployment/product-service.yaml"
LB_TEMPLATE="$SCRIPT_DIR/deployment/angular-lb-template.yaml"
LB_CONFIG="$SCRIPT_DIR/deployment/angular-lb.yaml"

# Replace placeholders in deployment templates
for TEMPLATE in "$CART_TEMPLATE" "$PRODUCT_TEMPLATE" "$LB_TEMPLATE"; do
  TARGET_FILE="${TEMPLATE/-template/}"
  cp "$TEMPLATE" "$TARGET_FILE"
  sed -i "s|{{VERSION_TAG}}|$VERSION|g" "$TARGET_FILE"
  sed -i "s|{{DEPLOYMENT_COLOR}}|$DEPLOYMENT_COLOR|g" "$TARGET_FILE"
done

# Deploy service
echo "Deleting Services..."
kubectl delete -f "$CART_CONFIG"
kubectl delete -f "$LB_CONFIG"
kubectl delete -f "$PRODUCT_CONFIG"

# Clean up deployment config
rm "$CART_CONFIG" "$PRODUCT_CONFIG" "$LB_CONFIG"

echo "Service Deletion complete."
