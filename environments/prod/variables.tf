# ============================================
# Subscription Variables
# ============================================

variable "connectivity_subscription_id" {
  description = "Azure Subscription ID for SDE Connectivity Subscription"
  type        = string
  sensitive   = true
}

variable "data_lz_subscription_id" {
  description = "Azure Subscription ID for SDE Data Landing Zone Subscription"
  type        = string
  sensitive   = true
}

variable "management_subscription_id" {
  description = "Azure Subscription ID for SDE Management Subscription"
  type        = string
  sensitive   = true
}

# ============================================
# Virtual Network Variables
# ============================================

variable "virtual_networks" {
  description = "Map of Virtual Network configurations across subscriptions"
  type = map(object({
    provider_alias      = string
    is_applicable       = bool
    region              = string
    resource_group_name = string
    address_space       = list(string)
    tags                = map(string)
  }))
}

# ============================================
# Subnet Variables
# ============================================

variable "subnet_config" {
  description = "List of subnet configurations across all VNets"
  type = list(object({
    provider_alias                  = string
    is_applicable                   = bool
    resource_group_name             = string
    virtual_network_name            = string
    name                            = string
    address_prefixes                = list(string)
    default_outbound_access_enabled = bool
    allow_private_endpoint          = optional(bool, false)
    service_endpoints               = optional(list(string), [])
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), [])
  }))
}
