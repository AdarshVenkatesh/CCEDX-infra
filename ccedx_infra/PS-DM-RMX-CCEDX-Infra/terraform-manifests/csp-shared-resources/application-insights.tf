##############################################################################################################
# RESOURCES - (Application Insights)
##############################################################################################################

resource "azurerm_application_insights" "app_insights" {
  name                = local.app_insights_name
  location            = var.resourcegroup_location
  resource_group_name = var.csp_resource_group
  workspace_id        = var.utp_workspace_id
  application_type    = "web"
}