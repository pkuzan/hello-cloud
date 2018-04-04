resource "azurerm_resource_group" "resourcegroup" {
  name = "helloCloudResourceGroup"
  location = "eastus"

  tags {
    environment = "Hello Cloud"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name = "helloCloudVnet"
  address_space = [
    "10.0.0.0/16"]
  location = "eastus"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

  tags {
    environment = "Hello Cloud"
  }
}

resource "azurerm_subnet" "subnet" {
  name = "helloCloudSubnet"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix = "10.0.2.0/24"
}

resource "azurerm_public_ip" "publicip" {
  name = "helloCloudPublicIP"
  location = "eastus"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "Hello Cloud"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name = "helloCloudNetworkSecurityGroup"
  location = "eastus"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

  security_rule {
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "Hello Cloud"
  }
}

resource "azurerm_network_interface" "nic" {
  name = "helloCloudNIC"
  location = "eastus"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"

  ip_configuration {
    name = "myNicConfiguration"
    subnet_id = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.publicip.id}"
  }

  tags {
    environment = "Hello Cloud"
  }
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${azurerm_resource_group.resourcegroup.name}"
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storageaccount" {
  name = "diag${random_id.randomId.hex}"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  location = "eastus"
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "Hello Cloud"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "myterraformvm" {
  name = "helloCloudVM"
  location = "eastus"
  resource_group_name = "${aazurerm_resource_group.resourcegroup.name}"
  network_interface_ids = [
    "${azurerm_network_interface.nic.id}"]
  vm_size = "Standard_DS1_v2"

  storage_os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "16.04.0-LTS"
    version = "latest"
  }

  os_profile {
    computer_name = "myvm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/azureuser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3Nz{snip}hwhqT9h"
    }
  }

  boot_diagnostics {
    enabled = "true"
    storage_uri = "${azurerm_storage_account.storageaccount.primary_blob_endpoint}"
  }

  tags {
    environment = "Hello Cloud"
  }
}
