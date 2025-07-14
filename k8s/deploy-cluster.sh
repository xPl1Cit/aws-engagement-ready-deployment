#!/bin/bash

# Check if region is passed as an argument
if [ -z "$1" ]; then
  echo "Region not provided. Using default region: us-east-1"
  REGION="us-east-1"  # Default to us-east-1 if no region is provided
else
  REGION=$1
  echo "Using region: $REGION"
fi

# Check if region is passed as an argument
if [ -z "$2" ]; then
  echo "Environment not provided. Using default environment: test"
  ENV="test"  # Default to test if no environment is provided
else
  ENV=$2
  echo "Using environment: $ENV"
fi

cd ..
cd terraform
./deploy-stage.sh $ENV 
./deploy-db-secret.sh $ENV 