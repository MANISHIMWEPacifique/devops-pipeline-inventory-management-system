# Setup Azure Storage for Terraform State
# Run this script ONCE before using Terraform

$RESOURCE_GROUP="terraform-state-rg"
$STORAGE_ACCOUNT="tfstatedevopsdev"
$CONTAINER_NAME="tfstate"
$LOCATION="eastus"

Write-Host "=== Creating Azure Storage for Terraform State ===" -ForegroundColor Cyan

# Create resource group
Write-Host "`nCreating resource group: $RESOURCE_GROUP" -ForegroundColor Yellow
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account
Write-Host "`nCreating storage account: $STORAGE_ACCOUNT" -ForegroundColor Yellow
az storage account create `
  --resource-group $RESOURCE_GROUP `
  --name $STORAGE_ACCOUNT `
  --sku Standard_LRS `
  --encryption-services blob

# Get storage account key
Write-Host "`nGetting storage account key..." -ForegroundColor Yellow
$ACCOUNT_KEY = az storage account keys list `
  --resource-group $RESOURCE_GROUP `
  --account-name $STORAGE_ACCOUNT `
  --query '[0].value' `
  --output tsv

# Create blob container
Write-Host "`nCreating blob container: $CONTAINER_NAME" -ForegroundColor Yellow
az storage container create `
  --name $CONTAINER_NAME `
  --account-name $STORAGE_ACCOUNT `
  --account-key $ACCOUNT_KEY

Write-Host "`n=== Setup Complete! ===" -ForegroundColor Green
Write-Host "`nStorage Account Details:" -ForegroundColor Cyan
Write-Host "Resource Group: $RESOURCE_GROUP"
Write-Host "Storage Account: $STORAGE_ACCOUNT"
Write-Host "Container: $CONTAINER_NAME"
Write-Host "`nYou can now run 'terraform init' in the terraform directory!" -ForegroundColor Green
