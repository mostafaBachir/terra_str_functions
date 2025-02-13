# ==========================
# AI Services (ai_services.tf)
# ==========================
# Custom Vision
resource "azurerm_cognitive_account" "custom_vision" {
  name                = "ai-customvision"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "CustomVision.Training"
  sku_name            = "S0"
}

# Computer Vision API
resource "azurerm_cognitive_account" "computer_vision" {
  name                = "ai-computervision"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "ComputerVision"
  sku_name            = "S1"
}
resource "azurerm_application_insights" "ml_insights" {
  name                = "ai-ml-insights"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}
resource "azurerm_key_vault" "ml_key_vault" {
  name                        = "ai-ml-keyvault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  sku_name                    = "standard"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

data "azurerm_client_config" "current" {}  # Obtient l'ID du tenant automatiquement
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                = "ai-ml-workspace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Basic"

  application_insights_id = azurerm_application_insights.ml_insights.id  
  key_vault_id           = azurerm_key_vault.ml_key_vault.id  
  storage_account_id     = azurerm_storage_account.blob_storage.id  # ✅ Réutilisation

  identity {
    type = "SystemAssigned"
  }
}
