# ==========================
# IoT Infrastructure (iot.tf)
# ==========================
resource "azurerm_iothub" "iot_hub" {
  name                = "ai-locomotive-iothub"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku {
    name     = "S1"
    capacity = 1
  }
}