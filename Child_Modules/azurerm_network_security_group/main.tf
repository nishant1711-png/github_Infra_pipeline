resource "azurerm_network_security_group" "nsg" {

  for_each = var.nsgs

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
}

resource "azurerm_network_security_rule" "ssh" {

  for_each = var.nsgs

  name      = "Allow-SSH"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

resource "azurerm_network_security_rule" "http" {

  for_each = var.nsgs

  name      = "Allow-HTTP"
  priority  = 110
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "80"

  source_address_prefix      = "*"
  destination_address_prefix = "*"

  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

data "azurerm_subnet" "subnet" {

  for_each = var.nsgs

  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name

}

resource "azurerm_subnet_network_security_group_association" "assoc" {

  for_each = var.nsgs

  subnet_id = data.azurerm_subnet.subnet[each.key].id

  network_security_group_id = azurerm_network_security_group.nsg[each.key].id

}