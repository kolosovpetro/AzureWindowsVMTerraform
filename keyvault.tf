module "key_vault" {
  count                  = var.keyvault_enabled ? 1 : 0
  source                 = "./modules/keyvault"
  kv_location            = azurerm_resource_group.public.location
  kv_name                = "kv-vm-win-${var.prefix}"
  kv_resource_group_name = azurerm_resource_group.public.name
  object_id              = data.azurerm_client_config.current.object_id
  tenant_id              = data.azurerm_client_config.current.tenant_id
}

module "key_vault_secrets" {
  count                     = var.keyvault_enabled ? 1 : 0
  source                    = "./modules/keyvault-secrets"
  keyvault_id               = module.key_vault[0].id
  storage_access_url        = module.storage[0].storage_access_url
  storage_account_name      = module.storage[0].storage_account_name
  storage_connection_string = module.storage[0].storage_connection_string
  storage_container_name    = module.storage[0].storage_container_name
  storage_primary_key       = module.storage[0].storage_primary_key

  depends_on = [
    module.key_vault,
    module.storage
  ]
}

module "keyvault_access_policy" {
  count       = var.keyvault_enabled ? 1 : 0
  source      = "./modules/keyvault-access-policy"
  keyvault_id = module.key_vault[0].id
  object_id   = module.virtual_machine.principal_id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  depends_on = [
    module.key_vault,
    module.virtual_machine
  ]
}
