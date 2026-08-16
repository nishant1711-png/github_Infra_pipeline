resource "azurerm_resource_group" "rg-block" {
  for_each = var.rgs
  name     = each.value.rg_name
  location = each.value.location
}