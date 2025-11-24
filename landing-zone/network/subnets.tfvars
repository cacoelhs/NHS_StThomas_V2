# ============================================
# Subnet Configuration
# ============================================

subnet_config = [
  # ============================================
  # SDE Connectivity Subscription Subnets
  # ============================================

  {
    provider_alias                  = "connectivity-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-conn-rg01"
    virtual_network_name            = "gstt-sde-uks-prod-conn-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.16.64/26"
    ]
    name = "GatewaySubnet"
  },

  {
    provider_alias                  = "connectivity-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-conn-rg01"
    virtual_network_name            = "gstt-sde-uks-prod-conn-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.16.0/26"
    ]
    name = "AzureFirewallSubnet"
  },

  {
    provider_alias                  = "connectivity-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-conn-rg01"
    virtual_network_name            = "gstt-sde-uks-prod-conn-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.16.128/26"
    ]
    name = "gstt-sde-uks-prod-conn-dns-inbound-snet01"
    delegation = [{
      name = "Microsoft.Network.dnsResolvers"
      service_delegation = {
        name = "Microsoft.Network/dnsResolvers"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }]
  },

  {
    provider_alias                  = "connectivity-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-conn-rg01"
    virtual_network_name            = "gstt-sde-uks-prod-conn-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.16.192/26"
    ]
    name = "gstt-sde-uks-prod-conn-dns-outbound-snet01"
    delegation = [{
      name = "Microsoft.Network.dnsResolvers"
      service_delegation = {
        name = "Microsoft.Network/dnsResolvers"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }]
  },

  {
    provider_alias                  = "connectivity-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-conn-rg01"
    virtual_network_name            = "gstt-sde-uks-prod-conn-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.17.0/28"
    ]
    name = "gstt-sde-uks-prod-conn-vpn-p2s-pool-snet01"
  },

  # ============================================
  # SDE Data Landing Zone Subnets
  # ============================================

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.48/28"
    ]
    name                   = "gstt-sde-uks-prod-dev-storage-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage",
      "Microsoft.KeyVault",
      "Microsoft.Sql"
    ]
  },

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.32/28"
    ]
    name                   = "gstt-sde-uks-prod-data-storage-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage",
      "Microsoft.KeyVault",
      "Microsoft.Sql"
    ]
  },

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.16/28"
    ]
    name                   = "gstt-sde-uks-prod-dev-snowflake-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage"
    ]
  },

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.0/28"
    ]
    name                   = "gstt-sde-uks-prod-data-snowflake-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage"
    ]
  },

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.64/28"
    ]
    name                   = "gstt-sde-uks-prod-data-adf-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage",
      "Microsoft.KeyVault",
      "Microsoft.Sql"
    ]
  },

  {
    provider_alias                  = "data-lz-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-data-rg01"
    virtual_network_name            = "gst-uks-sde-data-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.80/28"
    ]
    name                   = "gstt-sde-uks-prod-dev-adf-snet01"
    allow_private_endpoint = true
    service_endpoints = [
      "Microsoft.Storage",
      "Microsoft.KeyVault",
      "Microsoft.Sql"
    ]
  },

  # ============================================
  # SDE Management Subscription Subnets
  # ============================================

  {
    provider_alias                  = "management-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-mng-rg01"
    virtual_network_name            = "gst-uks-sde-mng-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.192/26"
    ]
    name = "AzureBastionSubnet"
  },

  {
    provider_alias                  = "management-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-mng-rg01"
    virtual_network_name            = "gst-uks-sde-mng-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.160/28"
    ]
    name = "ACIDevSubnet"
    delegation = [{
      name = "Microsoft.ContainerInstance.containerGroups"
      service_delegation = {
        name = "Microsoft.ContainerInstance/containerGroups"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }]
  },

  {
    provider_alias                  = "management-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-mng-rg01"
    virtual_network_name            = "gst-uks-sde-mng-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.144/28"
    ]
    name                   = "PrivateEndpointsSubnet"
    allow_private_endpoint = true
  },

  {
    provider_alias                  = "management-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-mng-rg01"
    virtual_network_name            = "gst-uks-sde-mng-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.128/28"
    ]
    name = "ACIProdSubnet"
    delegation = [{
      name = "Microsoft.ContainerInstance.containerGroups"
      service_delegation = {
        name = "Microsoft.ContainerInstance/containerGroups"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    }]
  },

  {
    provider_alias                  = "management-sub"
    is_applicable                   = true
    resource_group_name             = "gstt-sde-uks-prod-mng-rg01"
    virtual_network_name            = "gst-uks-sde-mng-vnet01"
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.31.20.176/28"
    ]
    name = "JumpServerSubnet"
    service_endpoints = [
      "Microsoft.Storage",
      "Microsoft.KeyVault"
    ]
  }
]
