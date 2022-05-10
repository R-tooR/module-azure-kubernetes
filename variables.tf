variable "env_name" {
  type = string
  default = "australiaeast"
}

variable "resource_group_name" {
  type = string
}

variable "nodegroup_size" {
  type = string
  default = "Standard_B2s"
}

variable "nodegroup_max_pod_size" {
  type = number
}

variable "nodegroup_max_size" {
  type = number
  default = 1
}

variable "nodegroup_min_size" {
  type = number
  default = 1
}

variable "nodegroup_disk_size" {
  type = string
  default = "nodegroup_disk_size"
}

variable "private_subnet_id" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "cluster_name" {
  type = string
}
