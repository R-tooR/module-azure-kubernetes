provider "azurerm" {
  features {}
}

locals {
  cluster_name = "${var.cluster_name}-${var.azure_region}"
  pool_name    = "mspool"
}

resource "azurerm_kubernetes_cluster" "ms-up-running" {

  location            = var.azure_region
  name                = local.cluster_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }

  default_node_pool {
    name                  = local.pool_name
    vm_size               = var.nodegroup_size # Standard_B2s
    max_pods              = var.nodegroup_max_pod_size
    max_count             = var.nodegroup_max_size
    min_count             = var.nodegroup_min_size
    type                  = "VirtualMachineScaleSets"
    os_disk_size_gb       = var.nodegroup_disk_size # osDiskSizeGB
#    enable_node_public_ip = true
    enable_auto_scaling   = true
  }

  network_profile {
    network_plugin = "kubenet"
  }
}

resource "local_file" "kubeconfig" {
  filename = "kubeconfig"
  content  = <<KUBECONFIG_END
apiVersion: v1
clusters:
- cluster:
    "certificate-authority-data: >
    ${azurerm_kubernetes_cluster.ms-up-running.kube_config.0.client_certificate}"
    server: ${azurerm_kubernetes_cluster.ms-up-running.dns_prefix}
  name: ${azurerm_kubernetes_cluster.ms-up-running.name}
contexts:
- context:
    cluster: ${azurerm_kubernetes_cluster.ms-up-running.name}
    user: ${azurerm_kubernetes_cluster.ms-up-running.name}
  name: ${azurerm_kubernetes_cluster.ms-up-running.name}
current-context: ${azurerm_kubernetes_cluster.ms-up-running.name}
kind: Config
preferences: {}
  KUBECONFIG_END
}