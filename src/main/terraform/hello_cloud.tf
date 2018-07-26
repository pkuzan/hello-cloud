
resource "azurerm_public_ip" "publicip" {
  name = "helloCloudPublicIP"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_interface" "nic" {
  name = "helloCloudNIC"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name = "myNicConfiguration"
    subnet_id = "${var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.publicip.id}"
  }

  tags {
    environment = "${var.environment}"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "virtual_machine" {
  name = "helloCloudVM"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = [
    "${azurerm_network_interface.nic.id}"]
  vm_size = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "7.3"
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
      key_data = "${var.ssh_key_data}"
    }
  }

  boot_diagnostics {
    enabled = "true"
    storage_uri = "${azurerm_storage_account.storageaccount.primary_blob_endpoint}"
  }

  tags {
    environment = "${var.environment}"
  }
}




