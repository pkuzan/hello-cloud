# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${var.resource_group_name}"
  }

  byte_length = 8
}

resource "azurerm_storage_account" "storageaccount" {
  name = "${var.storage_account_name}"
  resource_group_name = "${var.resource_group_name}"
  location = "${var.location}"
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_storage_container" "storageContainer" {
  name = "hello-cloud-storage-container"
  resource_group_name = "${var.resource_group_name}"
  storage_account_name = "${azurerm_storage_account.storageaccount.name}"
  container_access_type = "private"
}
