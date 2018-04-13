resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  name = "msiExtension"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  virtual_machine_name = "${azurerm_virtual_machine.virtual_machine.name}"
  publisher = "Microsoft.ManagedIdentity"
  type = "ManagedIdentityExtensionForLinux"
  type_handler_version = "1.0"

  settings = <<SETTINGS
    {
        "port": 50342
    }
  SETTINGS
}

resource "azurerm_virtual_machine_extension" "helloterraformvm" {
  name = "hostname"
  location = "${var.location}"
  resource_group_name = "${azurerm_resource_group.resourcegroup.name}"
  virtual_machine_name = "${azurerm_virtual_machine.virtual_machine.name}"
  publisher = "Microsoft.OSTCExtensions"
  type = "CustomScriptForLinux"
  type_handler_version = "1.2"

  settings = <<SETTINGS
    {
        "commandToExecute": "sudo yum -y install java-1.8.0-openjdk"
    }
  SETTINGS
}