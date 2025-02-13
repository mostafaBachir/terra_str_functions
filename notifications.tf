# ==========================
# Visualization & Notifications (notifications.tf)
# ==========================

resource "azurerm_notification_hub_namespace" "notif_namespace" {
  name                = "ai-notif-namespace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name           = "Standard"
  namespace_type     = "NotificationHub"  # 🚀 Correction ajoutée ici
}

resource "azurerm_notification_hub" "notif_hub" {
  name                = "ai-notif-hub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location  # 🚀 Correction ajoutée ici
  namespace_name      = azurerm_notification_hub_namespace.notif_namespace.name
}