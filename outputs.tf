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

output "namesapce_authorization_rule_ids" {
  description = "IDs of the namespace authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.id, [""]))
}

output "namesapce_authorization_rule_primary_key" {
  description = "The primary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.primary_key, [""]))
}

output "namesapce_authorization_rule_primary_connection string" {
  description = "The primary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.primary_connection_string, [""]))
}

output "namesapce_authorization_rule_secondary_key" {
  description = "The secondary keys for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.secondary_key, [""]))
}

output "namesapce_authorization_rule_secondary_connection string" {
  description = "The secondary connection string for the authorization rules."
  value       = compact(concat(azurerm_eventhub_namespace_authorization_rule.this.*.secondary_connection_string, [""]))
}
###
# Event-hub
###

###
# Event-hub authorization rules
###

###
# Event-hub consumer group
###
