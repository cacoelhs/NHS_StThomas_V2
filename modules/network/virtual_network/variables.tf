# ============================================
# Virtual Network Configuration Input
# ============================================

variable "vnet_config" {
  description = "Map of Virtual Network configurations"
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
# Subnet Configuration Input
# ============================================

variable "subnet_config" {
  description = "List of subnet configurations for the VNets"
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
