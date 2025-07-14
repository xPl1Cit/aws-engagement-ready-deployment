#!/bin/bash

set -e

# Get IAM identity info
ARN=$(aws sts get-caller-identity --query Arn --output text)
USERNAME=$(echo "$ARN" | awk -F'/' '{print $NF}')

echo "🔐 Mapping IAM user: $USERNAME ($ARN) to Kubernetes cluster admin"

# Patch aws-auth ConfigMap
kubectl get configmap aws-auth -n kube-system -o yaml > aws-auth-temp.yaml

# Inject user mapping if not already present
if grep -q "$ARN" aws-auth-temp.yaml; then
  echo "✅ User already mapped in aws-auth"
else
  echo "📦 Patching aws-auth..."

  cat <<EOF >> aws-auth-temp.yaml
mapUsers: |
  - userarn: $ARN
    username: $USERNAME
    groups:
      - system:masters
EOF

  kubectl apply -f aws-auth-temp.yaml
  echo "✅ Mapping applied successfully"
fi

rm aws-auth-temp.yaml
