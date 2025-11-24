# ============================================
# Azure Authentication Variables
# ============================================

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "azure_client_id" {
  description = "Azure Client ID for OIDC authentication"
  type        = string
  sensitive   = true
}

variable "azure_subscription_ids" {
  description = "Map of Azure Subscription IDs by environment"
  type        = map(string)
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
