locals {
  should_create_event_hubs = var.enabled && var.event_hub_enabled
  event_hub_namespaces     = zipmap(var.var.eventhub_namespace_names, compact(concat(azurerm_eventhub_namespace.this_namespace.*.name, [""])))
}
