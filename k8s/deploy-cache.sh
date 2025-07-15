#!/bin/bash

# Add and update Helm repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# Check if the Helm release already exists
if helm status redis >/dev/null 2>&1; then
    echo "✅ Helm release 'redis' already exists. Skipping installation."
else
    echo "🚀 Installing Redis..."
    helm install redis bitnami/redis -f k8s/deployment/redis-config.yaml
    echo "✅ Redis installed successfully."
fi
