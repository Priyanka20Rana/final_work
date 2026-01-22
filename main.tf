module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "networks" {
  source     = "../../modules/azurerm_networking"
  networks   = var.networks
  depends_on = [module.resource_group]
}

module "public_ip" {
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "key_vault" {
  source      = "../../modules/azurerm_key_vault"
  key_vaults  = var.key_vaults
  secrets     = var.secrets
  depends_on = [module.resource_group] 

}


module "virtual_machine" {
  depends_on = [module.resource_group, module.networks, module.key_vault]

  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}


# -------------------------
# SINGLE SQL SERVER
# -------------------------
module "sql_server" {
  source     = "../../modules/azurerm_sql_server"
  depends_on = [module.resource_group, module.key_vault ]

  sql_server_name              = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

# -------------------------
# SINGLE SQL DATABASE
# -------------------------
module "sql_database" {
  source     = "../../modules/azurerm_sql_database"
  depends_on = [module.sql_server]

  # You can also use this to always refer to module output
  sql_server_name = module.sql_server.sql_server_name

  resource_group_name = "rg-rachna"
  sql_database_name   = "tododb"
  location            = "centralus"
}
# module "container_registry" {
#   source               = "../../modules/azurerm_container_registry"
#   depends_on           = [module.resource_group]
#   container_registries = var.container_registries
# }

# module "kubernetes_cluster" {
#   source = "../../modules/azurerm_kubernetes_cluster"
#   depends_on = [
#     module.resource_group,
#     module.container_registry,
#     module.key_vault,]
#     kubernetes_clusters = var.kubernetes_clusters

# }
