#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "Script directory is: $SCRIPT_DIR"

ANGULAR_CONFIG="$SCRIPT_DIR/deployment/angular-autoscale.yaml"
CART_CONFIG="$SCRIPT_DIR/deployment/cart-autoscale.yaml"
PRODUCT_CONFIG="$SCRIPT_DIR/deployment/product-autoscale.yaml"

# Deploy both autoscaler
echo "Deploying Angular and Spring autoscaler..."
kubectl apply -f "$ANGULAR_CONFIG"
kubectl apply -f "$CART_CONFIG"
kubectl apply -f "$PRODUCT_CONFIG"

echo "Autoscaling Deployment complete."