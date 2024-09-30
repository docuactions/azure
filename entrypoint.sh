#!/bin/bash

# Fail on any error
set -e

# Log into Azure
echo "Logging into Azure..."
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Set the subscription
az account set --subscription $AZURE_SUBSCRIPTION_ID

# Copy the project files from the repository to the working directory
echo "Copying project files..."
cp -r /usr/src/app/* .

# Install project dependencies
echo "Installing project dependencies..."
npm install

# Build the Docusaurus site
echo "Building Docusaurus site..."
npm run build

# Deploy to Azure Container Apps (customize this part based on your deployment flow)
echo "Deploying to Azure Container Apps..."
az containerapp up --name $AZURE_APP_NAME --resource-group $AZURE_RESOURCE_GROUP --image mydockerimage:v1 --target-port 80 --ingress external

echo "Deployment completed."
