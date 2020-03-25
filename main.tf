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
  maximum_throughput_units = var.eventhub_namespace_auto_inflate_enabled != false ? var.eventhub_namespace_maximum_throughput_units : null

  dynamic "network_rulesets" {
    for_each = var.network_rulesets
    content {
      default_action = network_rulesets.value.default_action

      ip_rule {
        ip_mask = network_rulesets.value.ip_mask
        action  = "Allow"
      }
      virtual_network_rule {
        subnet_id                                       = network_rulesets.value.subnet_ids
        ignore_missing_virtual_network_service_endpoint = network_rulesets.value.ignore_missing_virtual_network_service_endpoint
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
  namespace_name      = var.event_hub_namespace_exist != false ? element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0) : element(var.event_hub_existing_namespace_names, count.index)
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
  namespace_name      = var.event_hub_namespace_exist != false ? element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0) : element(var.event_hub_existing_namespace_names, count.index)
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
  namespace_name      = var.event_hub_namespace_exist != false ? element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0) : element(var.event_hub_existing_namespace_names, count.index)
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
  namespace_name      = var.event_hub_namespace_exist != false ? element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0) : element(var.event_hub_existing_namespace_names, count.index)
  eventhub_name       = var.event_hub_count > 1 ? lookup(local.eventhub_name, element(var.consumer_group_event_hub_names, count.index)) : element(concat(azurerm_eventhub.this.*.name, var.existing_event_hub_names), count.index)
  resource_group_name = var.resource_group_name
  user_metadata       = element(var.consumer_group_user_metadatas, count.index)

  depends_on = [azurerm_eventhub.this]
}

###
# Event-hub namespace disaster recovery
###

resource "azurerm_eventhub_namespace_disaster_recovery_config" "this_recovery" {
  count = local.should_create_namespace_recovery ? length(var.event_hub_namespace_recovery_names) : 0

  name                 = element(var.event_hub_namespace_recovery_names, count.index)
  resource_group_name  = var.resource_group_name
  namespace_name       = var.event_hub_namesapce_disaster_recovery_exist != false ? element(var.event_hub_existing_namesapce_disaster_recovery_names, count.index) : element(concat(azurerm_eventhub_namespace.this_namespace.*.name, list("")), 0)
  partner_namespace_id = element(var.event_hub_namespace_recovery_partner_namespace_ids, count.index)
  alternate_name       = element(var.event_hub_namespace_alternate_names, count.index)
}
