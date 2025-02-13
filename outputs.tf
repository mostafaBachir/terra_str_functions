
# ==========================
# Outputs (outputs.tf)
# ==========================
output "iot_hub_connection_string" {
  value = azurerm_iothub.iot_hub.event_hub_events_endpoint
}
output "ml_workspace_id" {
  value = azurerm_machine_learning_workspace.ml_workspace.id
}
