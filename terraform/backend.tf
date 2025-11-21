terraform { 
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  # NOTE: Using local state due to Azure for Students policy restrictions
  # The state file will be stored locally in terraform.tfstate
  # 
  # If you want to use remote state later, uncomment the backend block below
  # and run: terraform init -migrate-state
  #
  # backend "azurerm" {
  #   resource_group_name  = "terraform-state-rg"
  #   storage_account_name = "YOUR_STORAGE_ACCOUNT_NAME"
  #   container_name       = "tfstate"
  #   key                  = "devops-pipeline.tfstate"
  # }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}