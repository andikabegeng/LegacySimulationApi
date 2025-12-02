#!/bin/bash

AWS_REGION="ap-southeast-1"
AWS_ACCOUNT="<isi aws acount yg ada..>"
REPO_NAME="legacy-sim-api"
IMAGE_TAG="latest"

echo "Logging in to ECR..."
podman login \
  -u AWS \
  -p $(aws ecr get-login-password --region $AWS_REGION) \
  $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com

echo "Tagging image..."
podman tag $REPO_NAME:$IMAGE_TAG \
  $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

echo "Pushing image to ECR..."
podman push \
  $AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

echo "Done!"