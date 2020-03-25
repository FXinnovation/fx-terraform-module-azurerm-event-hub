###
# Event-hub namespace
###

output "eventhub_namespace_id" {
  description = "The ID of the event hub namespace."
  value       = element(concat(azurerm_eventhub_namespace.this_namespace.*.id, list("")), 0)
}

###
# Event-hub namespace authorization rules
###

output "namespace_authorization_rule_ids" {
  description = "IDs of the namespace authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.id, [""]))
}

output "namesapce_authorization_rule_primary_key" {
  description = "The primary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.primary_key, [""]))
}

output "namesapce_authorization_rule_primary_connection_string" {
  description = "The primary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.primary_connection_string, [""]))
}

output "namesapce_authorization_rule_secondary_key" {
  description = "The secondary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.secondary_key, [""]))
}

output "namesapce_authorization_rule_secondary_connection_string" {
  description = "The secondary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.secondary_connection_string, [""]))
}

###
# Event-hub
###

output "event_hub_ids" {
  description = "IDs of the event hub."
  value       = compact(concat(azurerm_eventhub.this.*.id, [""]))
}

output "event_hub_partition_ids" {
  description = "Identifiers for partitions created for the eventhub."
  value       = azurerm_eventhub.this.*.partition_ids
}

###
# Event-hub authorization rules
###

output "eventhub_authorization_rule_ids" {
  description = "IDs of the eventhub authorization rules."
  value       = compact(concat(azurerm_eventhub_authorization_rule.this_rule.*.id, [""]))
}

output "eventhub_authorization_rule_primary_key" {
  description = "The primary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_authorization_rule.this_rule.*.primary_key, [""]))
}

output "eventhub_authorization_rule_primary_connection_string" {
  description = "The primary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_authorization_rule.this_rule.*.primary_connection_string, [""]))
}

output "eventhub_authorization_rule_secondary_key" {
  description = "The secondary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_authorization_rule.this_rule.*.secondary_key, [""]))
}

output "eventhub_authorization_rule_secondary_connection_string" {
  description = "The secondary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_authorization_rule.this_rule.*.secondary_connection_string, [""]))
}

###
# Event-hub consumer group
###

output "eventhub_consumer_group_ids" {
  description = "IDs of the eventhub consumer group."
  value       = compact(concat(azurerm_eventhub_consumer_group.this.*.id, [""]))
}

###
# Event-hub namespace disaster recovery
###

output "recovery_eventhub_namespace_ids" {
  description = "IDs of the eventhub namespace diaster recovery config."
  value       = compact(concat(azurerm_eventhub_namespace_disaster_recovery_config.this_recovery.*.id, [""]))
}
