# ==========================
# Azure Functions (functions.tf)
# ==========================
resource "azurerm_storage_account" "function_storage" {
  name                     = "aifunctionstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function_plan" {
  name                = "ai-function-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "function_app" {
  name                = "ai-function-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.function_plan.id  # ✅ Changement de `app_service_plan_id`
  storage_account_name = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  site_config {
    always_on = true
    ftps_state = "Disabled"  # Désactive le FTPS pour la sécurité
    http2_enabled = true
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"  # Modifie selon ton langage (dotnet, node, python)
  }

  identity {
    type = "SystemAssigned"
  }
}
