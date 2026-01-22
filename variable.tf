variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "networks" {
  description = "Map of VNets with optional subnets"
  
  type = map(object({
    vnet_name              = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
    tags                = optional(map(string))
    
    # Subnet is optional; default empty map to avoid null for_each
    subnet = optional(map(object({
      name             = string
      address_prefixes = list(string)
    })), {})
  }))
}
variable "public_ips" {
  description = "Map of Public IP configurations"
  type = map(object({
    name                    = string
    resource_group_name     = string
    location                = string
    allocation_method       = string # Static / Dynamic
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    zones                   = optional(list(string), [])
    ip_version              = optional(string, "IPv4")
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number, 4)
    ip_tags                 = optional(map(string), {})
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    tags                    = optional(map(string), {})
  }))
}


variable "vms" {
  type = map(object({
    nic_name               = string
    vm_name             = string
    location               = string
    resource_group_name    = string
    size                   = string
    vnet_name              = string
    subnet_name            = string
    pip_name               = string
    admin_username         = string
    admin_password         = string
    source_image_reference = map(string)
  }))
}

variable "key_vaults" {
  type = map(object({
    kv_name                = string
    location               = string
    resource_group_name    = string
    sku_name               = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
  }))
}

variable "secrets" {
  type = map(object({
    secret_name  = string
    secret_value = string
    key_vault_key = string   # <-- points to key_vaults ka key
  }))
}



variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  type = string
  description = "Name of the SQL database"
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL Server will be created."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server."
  type        = string
}

variable "administrator_login_password" {
  description = "The password for the administrator login."
  type        = string
  sensitive   = true
}


# variable "container_registries" {
#   type = map(object({
#     name                = string
#     resource_group_name = string
#     location            = string
#     sku                 = string
#     admin_enabled       = bool

#   }))
# }

# variable "kubernetes_clusters" {
#   description = "Map of Kubernetes clusters to be created"
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string
#     dns_prefix          = string

#     default_node_pool = object({
#       name       = string
#       node_count = number
#       vm_size    = string
#     })

#     identity_type = string # <- yahaan sirf ek field hai, isliye object ki zarurat nahi
#     tags          = map(string)
#   }))
# }


