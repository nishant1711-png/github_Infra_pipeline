data "azurerm_subnet" "snet-block" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_network_interface" "nic-block" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "dev"
    subnet_id                     = data.azurerm_subnet.snet-block[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm-block" {
  for_each            = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic-block[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_key_vault" "kv" {
  for_each            = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}

data "azurerm_key_vault_secret" "password" {
  for_each     = var.vms
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}