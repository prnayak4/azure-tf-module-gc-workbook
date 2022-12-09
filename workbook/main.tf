terraform {
  #backend "remote" {}
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
}
#data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

 
resource "azurerm_resource_group_template_deployment" "complianceworkbook" {
  name                = "complianceworkbook"
  resource_group_name = var.ResourceGroupName
template_content   = templatefile ("${path.module}/ComplianceWorkbook/GCWorkbook.json",
{
  sub_id = data.azurerm_subscription.current.id
  subscription_id = data.azurerm_subscription.current.subscription_id
	sub_name = data.azurerm_subscription.current.display_name
})
  deployment_mode = "Incremental"
}

