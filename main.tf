###
# Event-Hub namespace
###

resource "azurerm_eventhub_namespace" "this_namespace" {
  count = var.enabled ? length(var.eventhub_namespace_names) : 0

  name                     = element(var.eventhub_namespace_names, count.index)
  resource_group_name      = var.resource_group_name
  location                 = element(var.eventhub_namespace_locations, count.index)
  sku                      = element(var.eventhub_namespace_skus, count.index)
  capacity                 = element(var.eventhub_namespace_capacitiies, count.index)
  auto_inflate_enabled     = element(var.eventhub_namespace_auto_inflate_enabled, count.index)
  maximum_throughput_units = element(var.eventhub_namespace_maximum_throughput_units, count.index)

  dynamic "network_rulesets" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action = "Deny"

      dynamic "ip_rule" {
        for_each = var.network_rules.ip_rules
        iterator = iprule
        content {
          ip_mask = iprule.value
        }
      }

      dynamic "virtual_network_rule" {
        for_each = var.network_rules.subnet_ids
        iterator = subnet
        content {
          subnet_id = subnet.value
        }
      }
    }
  }

  tags = merge(
    var.tags,
    var.eventhub_namespace_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# Event-Hub namespace authorization rules
###

resource "azurerm_eventhub_namespace_authorization_rule" "this" {
  count = var.enabled && var.namespace_authorization_rule_enabled ? length(var.namespace_authorization_rule_names) : 0

  name                = element(var.namespace_authorization_rule_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  listen              = element(var.namespace_authorization_rule_listens, count.index)
  send                = element(var.namespace_authorization_rule_sends, count.index)
  manage              = element(var.namespace_authorization_rule_manages, count.index)
}

###
# Event-Hub
###

resource "azurerm_eventhub" "this" {
  count = local.should_create_event_hubs ? var.event_hub_count : 0

  name                = element(var.event_hub_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  partition_count     = element(var.event_hub_partititon_counts, count.index)
  message_retention   = element(var.event_hub_message_rententions, count.index)

  dynamic "capture_description" {
    for_each = element(var, capture_description_enabled, count.index) != false ? [1] : []

    content {
      enabled = false
    }
  }

}
