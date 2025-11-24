variable "environment" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "UK South"
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "nhs-stthomas"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

locals {
  default_tags = {
    Project   = "NHS St Thomas V2"
    ManagedBy = "Terraform"
  }
  all_tags = merge(local.default_tags, { Environment = var.environment }, var.tags)
}
