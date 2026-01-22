rgs = {
  rg1 = {
    name       = "rg-rachna"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
  rg2 = {
    name       = "rg-sanjay"
    location   = "centralindia"
    managed_by = "terraform"
    tags = {
      env = "dev"
    }
  }
}

sql_server_name             = "akshaysqlserver"
resource_group_name         = "rg-rachna"
sql_database_name           = "akshaysqldatabase"
location                    = "centralindia"
administrator_login         = "adminuser"
administrator_login_password = "Akansha@123"

networks = {
  vnet1 = {
    vnet_name    = "sanjayvnet"
    location            = "centralindia"
    resource_group_name = "rg-rachna"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
    tags = {
      environment = "Development"
    }

    subnet = {
      s1 = {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      s2 = {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }

  vnet2 = {
    vnet_name                = "rachnavnet"
    location            = "centralindia"
    resource_group_name = "rg-rachna"
    address_space       = ["10.1.0.0/16"]
    tags = {
      environment = "Production"
    }

    # ✅ Add empty subnet to avoid null error
    subnet = {}
  }
}

public_ips = {
  app1 = {
    name                = "pip-rachna"
    resource_group_name = "rg-rachna"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }
  app2 = {
    name                = "pip-sanjay"
    resource_group_name = "rg-rachna"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "frontend"
      env = "prod"
    }
  }
}

vms = {
  vm1 = {
    nic_name            = "frontend-vm-nic"
    location            = "centralindia"
    resource_group_name = "rg-rachna"
    vm_name             = "frontend-vm"
    size                = "Standard_D2s_v3"

    vnet_name           = "sanjayvnet"   # ✅ FIX
    subnet_name         = "frontend-subnet"

    pip_name            = "frontend-pip-parvati"
    admin_username      = "akansha"
    admin_password      = "P@ssw0rd123"

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }

  vm2 = {
    nic_name            = "backend-vm-nic"
    location            = "centralindia"
    resource_group_name = "rg-rachna"
    vm_name             = "backend-vm"
    size                = "Standard_D2s_v3"

    vnet_name           = "sanjayvnet"   # ✅ FIX
    subnet_name         = "backend-subnet"

    pip_name            = "backend-pip-parvati"
    admin_username      = "akansha"
    admin_password      = "P@ssw0rd123"

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }
}



# container_registries = {
#   c1 = {
#     name                = "acrdevrachna"
#     resource_group_name = "rg-rachna"
#     location            = "centralus"
#     sku                 = "Standard"
#     admin_enabled       = true
#   }

#    c2 = {
#     name                = "acrprodsanjay"
#     resource_group_name = "rg-rachna"
#     location            = "centralus"
#     sku                 = "Standard"
#     admin_enabled       = true
#   }
# }

key_vaults = {
  kv1 = {
    kv_name = "sanjay1-dev-todoapp"
    location = "southindia"
    resource_group_name = "rg-rachna"
    sku_name = "standard"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
  }
}

secrets = {
  username = {
    secret_name  = "Username"
    secret_value = "adminuser"
    key_vault_key = "kv1"   
  }

  password = {
    secret_name  = "Password"
    secret_value = "Password@123"
    key_vault_key = "kv1"   
  }
}



# kubernetes_clusters = {
#   c1 = {
#     name                = "parvati-prod-cluster"
#     location            = "centralus"
#     resource_group_name = "rg-rachna"
#     dns_prefix          = "aksprod"
#     default_node_pool = {
#       name       = "default"
#       node_count = 1
#       vm_size    = "Standard_D2s_v3"
#     }
#     identity_type = "SystemAssigned"
#     tags = {
#       Environment = "Production"
#       Owner       = "Akansha"
#     }
#   }

#   c2 = {
#     name                = "shivaa-dev-cluster"
#     location            = "centralus"
#     resource_group_name = "rg-rachna"
#     dns_prefix          = "aksdev"
#     default_node_pool = {
#       name       = "default"
#       node_count = 1
#       vm_size    = "Standard_D2s_v3"
#     }
#     identity_type = "SystemAssigned"
#     tags = {
#       Environment = "Development"
#       Owner       = "Akshay"
#     }
#   }
# }