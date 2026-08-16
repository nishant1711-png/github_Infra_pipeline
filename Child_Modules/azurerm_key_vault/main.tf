resource "azurerm_key_vault" "kv" {
  for_each            = var.keyvaults
  name                = each.value.kv_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault_secret" "password" {
  for_each     = var.keyvaults
  name         = "vm-password"
  value        = each.value.password
  key_vault_id = azurerm_key_vault.kv[each.key].id
}