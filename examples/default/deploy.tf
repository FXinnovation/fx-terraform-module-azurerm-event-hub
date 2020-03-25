resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "West US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tftest-vnet${random_string.this.result}"
  address_space       = ["10.7.29.0/29"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "tftest-subnet${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.7.29.0/29"
  service_endpoints    = ["Microsoft.EventHub"]
}

module "example" {
  source = "../.."

  event_hub_namespace_enabled  = true
  eventhub_namespace_name      = "tftest${random_string.this.result}"
  resource_group_name          = azurerm_resource_group.example.name
  eventhub_namespace_location  = azurerm_resource_group.example.location
  eventhub_namespace_sku       = "Standard"
  eventhub_namespace_capacitiy = 2

  network_rulesets = [
    {
      default_action                                  = "Deny"
      ip_mask                                         = "10.7.39.0/32"
      subnet_id                                       = "${azurerm_subnet.subnet.id}"
      ignore_missing_virtual_network_service_endpoint = false
    }
  ]

  namespace_authorization_rule_enabled = true
  namespace_authorization_rule_names   = ["tftest${random_string.this.result}"]
  namespace_authorization_rule_listens = [true]
  namespace_authorization_rule_sends   = [true]
  namespace_authorization_rule_manages = [true]

  event_hub_enabled             = true
  event_hub_names               = ["tftest${random_string.this.result}", "tftestone${random_string.this.result}"]
  event_hub_partititon_counts   = [2]
  event_hub_message_rententions = [1]

  eventhub_authorization_rule_enabled = true
  eventhub_authorization_rule_names   = ["tftest${random_string.this.result}", "tftestone${random_string.this.result}"]
  authorization_rule_event_hub_names  = ["tftest${random_string.this.result}", "tftestone${random_string.this.result}"]
  eventhub_authorization_rule_listens = [true]
  eventhub_authorization_rule_sends   = [true]
  eventhub_authorization_rule_manages = [true]

  consumer_group_enabled         = true
  consumer_group_names           = ["tftest${random_string.this.result}"]
  consumer_group_event_hub_names = ["tftestone${random_string.this.result}"]

}
