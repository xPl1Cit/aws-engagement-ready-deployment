#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "Script directory is: $SCRIPT_DIR"

ANGULAR_CONFIG="$SCRIPT_DIR/deployment/angular-autoscale.yaml"
CART_CONFIG="$SCRIPT_DIR/deployment/cart-autoscale.yaml"
PRODUCT_CONFIG="$SCRIPT_DIR/deployment/product-autoscale.yaml"

# Deploy both autoscaler
echo "Deleting Angular and Spring autoscaler..."
kubectl delete -f "$ANGULAR_CONFIG"
kubectl delete -f "$CART_CONFIG"
kubectl delete -f "$PRODUCT_CONFIG"

echo "Autoscaling Deletion complete."