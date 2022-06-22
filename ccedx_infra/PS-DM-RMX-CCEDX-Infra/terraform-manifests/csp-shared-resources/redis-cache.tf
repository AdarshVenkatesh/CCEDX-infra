##############################################################################################################
# RESOURCES - (Redis Cache)
##############################################################################################################

resource "azurerm_redis_cache" "csp_redis_cache" {
  name                = local.csp_redis_name
  location            = var.resourcegroup_location
  resource_group_name = var.csp_resource_group
  capacity            = var.redis_cache_capacity[local.environment]
  family              = "C"
  sku_name            = "Standard"
  minimum_tls_version = "1.2"

  redis_configuration {
    maxmemory_reserved                 = 50
    maxfragmentationmemory_reserved    = 50
  }
}