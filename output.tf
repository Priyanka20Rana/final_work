output "dev_rg_ids" {
  value = module.resource_group.rg_ids
}

# output "dev_container_ids" {
#   value = module.container_registry.acr_ids
# }

output "dev_keyvault_ids" {
  value = module.key_vault.kv_ids
}

# output "dev_cluster_ids" {
#   value = module.kubernetes_cluster.cluster_ids
# }