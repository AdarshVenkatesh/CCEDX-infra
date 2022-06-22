##############################################################################################################
# VARIABLES
##############################################################################################################

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "environment" {
  description = "Azure resources environment"
}

variable "resourcegroup_location" {
  description = "Resource group location"
  default = "westus2"
  validation {
    condition = contains(["westus2", "eastus2"], var.resourcegroup_location)
    error_message = "The resource group location must be in the list westus2, eastus2."
  }
}

variable "redis_cache_capacity" {
  type = map(number)
  default = {
    sit   = 1
    uat   = 1
    prod  = 2 
  }
}

variable "application_insights_name" {
  default = "app-insights-csp"
}

variable "csp_resource_group" {
  type = string  
}

variable keyvault_accesspolicy_objects {
  description = "Key vault access policiy object ids"
  type = map(list(string))
  default = {
    sit    = ["0f49ed4c-1d56-45a9-9b72-adbca703c839","1525ccd5-5c53-4bd9-96af-c445b7e706e7"] # cluster agent pool object ids for sit environment
    uat    = ["a791a70f-c3a5-4a07-b21f-1740e43984e9","0a26b0fa-9dd7-4a3a-80b5-75ae06090215"] # cluster agent pool object ids for uat environment
    prod   = ["e14839af-dc6b-4e77-87e7-156e80ac677a","4bed5d87-21c6-4482-98d5-e87649a7695c"] # cluster agent pool object ids for prod environment
  }
}

variable "utp_workspace_id" {
  type = string
}

##############################################################################################################
# LOCALS
##############################################################################################################

locals {
  environment               = lower(var.environment)
  common_tags               = { Env = local.environment }
  csp_kv_name               = (var.environment == "sit" ? "csp-sit" : "csp-kevt-${local.environment}")
  app_insights_name         = "${var.application_insights_name}-${local.environment}-${random_id.random_suffix.dec}"
  csp_redis_name            = "csp-redis-${local.environment}-${random_id.random_suffix.dec}"
}