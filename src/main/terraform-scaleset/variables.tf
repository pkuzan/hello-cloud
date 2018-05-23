provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

variable "location" {
  description = "The location where resources are created"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources are created"
}

variable "application_port" {
  description = "The port that you want to expose to the external load balancer"
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "ssh_key_data" {
  description = "Enter a key-pair public key"
}
