/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
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

variable "location" {
  description = "The default Azure region for the resource provisioning"
}

variable "resource_group_name" {
  description = "Resource group name that will contain various resources"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "environment" {
  description = "Enter an environment e.g. DEV, UAT, PROD"
}

variable "application_port" {
  description = "Enter application port e.g. 80"
}

variable "ssh_key_data" {
  description = "Enter ssh public key"
}

variable "vm_username" {
  description = "Enter VM username"
}

variable "vm_password" {
  description = "Enter VM password"
}