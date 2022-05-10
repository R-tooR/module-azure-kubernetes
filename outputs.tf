output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.ms-up-running.id
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.ms-up-running.kube_config.0.client_certificate
}

output "aks_cluster_endpoint" {
  value = azurerm_kubernetes_cluster.ms-up-running.dns_prefix
}

output "aks_cluster_nodegroup_id" {
  value = azurerm_kubernetes_cluster.ms-up-running.default_node_pool.name
}