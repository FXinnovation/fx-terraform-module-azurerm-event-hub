###
# Event-hub namespace
###

resource "azurerm_eventhub_namespace" "this_namespace" {
  count = local.should_create_event_hub_namespace ? 1 : 0

  name                     = var.eventhub_namespace_name
  resource_group_name      = var.resource_group_name
  location                 = var.eventhub_namespace_location
  sku                      = var.eventhub_namespace_sku
  capacity                 = var.eventhub_namespace_capacitiy
  auto_inflate_enabled     = var.eventhub_namespace_auto_inflate_enabled
  maximum_throughput_units = var.eventhub_namespace_maximum_throughput_units

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
# Event-hub namespace authorization rules
###

resource "azurerm_eventhub_namespace_authorization_rule" "this" {
  count = local.should_create_namespace_authorization_rule ? length(var.namespace_authorization_rule_names) : 0

  name                = element(var.namespace_authorization_rule_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  listen              = element(var.namespace_authorization_rule_listens, count.index)
  send                = element(var.namespace_authorization_rule_sends, count.index)
  manage              = element(var.namespace_authorization_rule_manages, count.index)
}

###
# Event-hub
###

resource "azurerm_eventhub" "this" {
  count = local.should_create_event_hubs ? var.event_hub_count : 0

  name                = element(var.event_hub_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  partition_count     = element(var.event_hub_partititon_counts, count.index)
  message_retention   = element(var.event_hub_message_rententions, count.index)

  dynamic "capture_description" {
    for_each = element(var.capture_description_enabled, count.index) != false ? [1] : []

    content {
      enabled             = element(var.capture_description_enabled, count.index)
      encoding            = element(var.capture_description_encoding, count.index)
      interval_in_seconds = element(var.capture_description_interval_in_seconds, count.index)
      size_limit_in_bytes = element(var.capture_description_size_in_bytes, count.index)
      skip_empty_archives = element(var.capture_description_skip_empty_archives, count.index)

      dynamic "destination" {
        for_each = element(var.destination_names, count.index) != null ? [1] : []

        content {
          name                = element(var.destination_names, count.index)
          archive_name_format = element(var.destination_archive_name_formats, count.index)
          blob_container_name = element(var.destination_blob_container_names, count.index)
          storage_account_id  = element(var.destination_storage_account_ids, count.index)
        }
      }
    }
  }
}

###
# Event-hub authorization rules
###

resource "azurerm_eventhub_authorization_rule" "this_rule" {
  count = local.should_create_eventhub_authorization_rule ? length(var.eventhub_authorization_rule_names) : 0

  name                = element(var.eventhub_authorization_rule_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  eventhub_name       = var.event_hub_count > 1 ? lookup(local.eventhub_name, element(var.authorization_rule_event_hub_names, count.index)) : element(concat(azurerm_eventhub.this.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  listen              = element(var.eventhub_authorization_rule_listen, count.index)
  send                = element(var.eventhub_authorization_rule_sends, count.index)
  manage              = element(var.eventhub_authorization_rule_manages, count.index)
}

###
# Event-hub consumer group
###

resource "azurerm_eventhub_consumer_group" "this" {
  count = local.should_create_consumer_group ? length(var.consumer_group_names) : 0

  name                = element(var.consumer_group_names, count.index)
  namespace_name      = element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  eventhub_name       = var.event_hub_count > 1 ? lookup(local.eventhub_name, element(var.consumer_group_event_hub_names, count.index)) : element(concat(azurerm_eventhub.this.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  user_metadata       = element(var.consumer_group_user_metadatas, count.index)
}
