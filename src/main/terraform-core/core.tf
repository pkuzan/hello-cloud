resource "azurerm_resource_group" "resourcegroup" {
  name = "${var.resource_group_name}"
  location = "${var.location}"

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name = "helloCloudVnet"
  address_space = [
    "${var.vnet_cidr}"]
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_subnet" "subnet" {
  name = "helloCloudSubnet"
  resource_group_name = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix = "${var.subnet1_cidr}"
}
