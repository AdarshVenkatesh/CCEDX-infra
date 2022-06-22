##############################################################################################################
# RESOURCES - (Key vault)
##############################################################################################################

resource "azurerm_key_vault" "csp_kv" {
  name                        = local.csp_kv_name
  location                    = var.resourcegroup_location
  resource_group_name         = var.csp_resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "kv_csp_access_policy_for_clusters" {
  for_each            = toset(var.keyvault_accesspolicy_objects[local.environment])
  key_vault_id        = azurerm_key_vault.csp_kv.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = each.value
  key_permissions     = ["Get","List"]
  secret_permissions  = ["Get","List"]
  
  depends_on          = [azurerm_key_vault.csp_kv]
}