module "custom_script_extension" {
  count                                 = var.custom_script_extension_enabled ? 1 : 0
  source                                = "./modules/custom-script-extension"
  custom_script_extension_absolute_path = "D:/RiderProjects/02_PRIVATE_PROJECTS/AzureWindowsVMTerraform/scripts/install_iis.ps1"
  custom_script_extension_file_name     = "install_iis.ps1"
  extension_name                        = "extension1"
  storage_account_name                  = module.storage[0].storage_account_name
  storage_container_name                = module.storage[0].storage_container_name
  virtual_machine_id                    = module.virtual_machine.id

  depends_on = [
    module.storage,
    module.virtual_machine
  ]
}
