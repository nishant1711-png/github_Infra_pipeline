rg_mod = {
  rg1 = {
    rg_name  = "rg-dev-01"
    location = "eastus"
  }
  rg2 = {
    rg_name  = "rg-dev-03"
    location = "eastus"
  }

  rg3 = {
    rg_name  = "rg-dev-04"
    location = "eastus"
  }

   rg5 = {
    rg_name  = "rg-dev-05"
    location = "eastus"
  }
}

vnet_mod = {
  vnet1 = {
    vnet_name     = "vnet-dev-01"
    location      = "eastus"
    rg_name       = "rg-dev-01"
    address_space = ["10.0.0.0/16"]
  }
}

snet_mod = {
  snet1 = {
    subnet_name      = "subnet-dev-01"
    vnet_name        = "vnet-dev-01"
    rg_name          = "rg-dev-01"
    address_prefixes = ["10.0.1.0/24"]
  }

  snet2 = {
    subnet_name      = "subnet-dev-02"
    vnet_name        = "vnet-dev-01"
    rg_name          = "rg-dev-01"
    address_prefixes = ["10.0.2.0/24"]
  }
}

vms_mod = {
  vm1 = {
    vm_name        = "vm-dev-01"
    rg_name        = "rg-dev-01"
    subnet_name    = "subnet-dev-01"
    vnet_name      = "vnet-dev-01"
    nic_name       = "nic-dev-01"
    location       = "eastus"
    size           = "Standard_D4_v5"
    admin_username = "azureuser"
    admin_password = "Nishant@123"

  }

  vm2 = {
    vm_name        = "vm-dev-02"
    rg_name        = "rg-dev-01"
    subnet_name    = "subnet-dev-02"
    vnet_name      = "vnet-dev-01"
    nic_name       = "nic-dev-02"
    location       = "eastus"
    size           = "Standard_D4_v5"
    admin_username = "azureuser"
    admin_password = "Nishant@123"

  }
}