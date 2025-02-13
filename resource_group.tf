# ==========================
# Resource Group (resource_group.tf)
# ==========================
resource "azurerm_resource_group" "rg" {
  name     = "ai-locomotive-rg"
  location = "East US"
}
