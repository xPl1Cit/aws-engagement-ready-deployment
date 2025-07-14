#!/bin/bash

# Add and update Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Check if the Helm release already exists
if helm status prometheus >/dev/null 2>&1; then
    echo "✅ Helm release 'prometheus' already exists. Skipping installation."
else
    echo "🚀 Installing Prometheus stack..."
    helm install prometheus prometheus-community/kube-prometheus-stack -f k8s/deployment/prometheus-config.yaml
    echo "✅ Prometheus stack installed successfully."
fi
