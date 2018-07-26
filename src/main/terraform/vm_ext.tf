resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  name = "msiExtension"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
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

#https://gist.github.com/pkuzan/a8fbc202af4a365f94d541bfc3676221/raw/vm-config.sh
#https://gist.github.com/[gist_user]/[gist_id]/raw/[file_name]