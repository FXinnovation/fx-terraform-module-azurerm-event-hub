locals {
  should_create_event_hub_namespace          = var.enabled && var.event_hub_namespace_enabled
  should_create_event_hubs                   = var.enabled && var.event_hub_enabled
  should_create_namespace_authorization_rule = var.enabled && var.namespace_authorization_rule_enabled
  should_create_eventhub_authorization_rule  = var.enabled && var.eventhub_authorization_rule_enabled
  should_create_consumer_group               = var.enabled && var.consumer_group_enabled
  event_hub_name                             = zipmap(var.event_hub_names, compact(concat(azurerm_eventhub.this.*.name, [""])))
}
