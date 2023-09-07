module "storage" {
  count                       = var.storage_enabled ? 1 : 0
  source                      = "./modules/storage"
  storage_account_name        = "storvmwin${var.prefix}"
  storage_account_replication = var.storage_account_replication
  storage_account_tier        = var.storage_account_tier
  storage_container_name      = "contvmwin${var.prefix}"
  storage_location            = azurerm_resource_group.public.location
  storage_resource_group_name = azurerm_resource_group.public.name

  depends_on = [
    azurerm_resource_group.public
  ]
}
