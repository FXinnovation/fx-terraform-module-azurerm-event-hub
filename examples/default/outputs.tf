output "namespace_id" {
  description = "The ID of the event hub namespace."
  value       = module.example.eventhub_namespace_id
}

output "namespace_authorization_rule_ids" {
  description = "The IDs of the namespace authorization rule."
  value       = module.example.namespace_authorization_rule_ids
}

output "event_hub_ids" {
  description = "The IDs of the eventhub."
  value       = module.example.event_hub_ids
}

output "eventhub_authorization_rule_ids" {
  description = "The IDs of the eventhub authorization rule."
  value       = module.example.eventhub_authorization_rule_ids
}

output "consumer_group_ids" {
  description = "IDs of the eventhub consumer groups."
  value       = module.example.eventhub_consumer_group_ids
}

output "reovery_namespace_ids" {
  description = "IDs the disater recovery eventhub namespace."
  value       = module.example.recovery_eventhub_namespace_ids
}
