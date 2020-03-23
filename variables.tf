###
# General
###

variable "enabled" {
  description = "Enable or diasble module."
  default     = true
}

variable "resource_group_name" {
  description = "Name of the resource group of the eventhub namespace resources should be exist.Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource."
  default     = {}
}

###
# Event-hub namespace
###

variable "eventhub_namespace_name" {
  description = "Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created. If enabled values is `REQUIRED`."
  type        = string
  default     = ""
}

variable "eventhub_namespace_location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. If enabled value is `REQUIRED`."
  type        = string
  default     = ""
}

variable "eventhub_namespace_sku" {
  description = "Defines which tier to use. Valid options are `Basic` and `Standard`. If enabled value is `REQUIRED`."
  type        = string
  default     = "Basic"
}

variable "eventhub_namespace_capacitiy" {
  description = "Specifies the capacity / throughput units for a `Standard` SKU namespace. Valid values range from `1`-`20`."
  type        = number
  default     = 5
}

variable "eventhub_namespace_auto_inflate_enabled" {
  description = "Boolean flag which describes whether the auto inflate enabled for the eventhub namespace."
  type        = bool
  default     = false
}

variable "eventhub_namespace_maximum_throughput_units" {
  description = "Specifies the maximum number of throughput units when auto inflate is enabled. Valid values range from `1`-`20`."
  type        = number
  default     = 5
}

variable "network_rules" {
  description = "Network rules restricing access to the event hub."
  type        = object({ ip_rules = list(string), subnet_ids = list(string) })
  default     = null
}

variable "eventhub_namespace_tags" {
  description = "Tags which will be associated to the eventhub namespace."
  default     = {}
}

###
# Event-hub namespace authorization rules
###

variable "namespace_authorization_rule_enabled" {
  description = "Boolean flag which describes whether to enable the namespace authorization rules or not."
  default     = false
}

variable "namespace_authorization_rule_names" {
  description = "The list which specifies the names of the authorization rule. Changing this forces a new resourece to be created. If enabled value is `Required`."
  type        = list(string)
  default     = [""]
}

variable "namespace_authorization_rule_listens" {
  description = "The list of boolean flags which describes whether to grant listen access to authorization rule. Defaults to `false`."
  type        = list(bool)
  default     = [false]
}

variable "namespace_authorization_rule_sends" {
  description = "The list of boolean flags which describes whether to grant send access to authorization rule. Defaults to `false`."
  type        = list(bool)
  default     = [false]
}

variable "namespace_authorization_rule_manages" {
  description = "The list of boolean flags which describes whether to grant send access to authorization rule.When this property is `ture` both `listen` and `send` must be too. Defaults to `false`."
  type        = list(bool)
  default     = [false]
}

###
# Event-hub
###

variable "event_hub_enabled" {
  description = "Boolean flag which describes whether to enable the eventub resource or not."
  default     = false
}

variable "event_hub_count" {
  description = "The number of eventhun which will be deployed using this module. If enabled value is `Required`."
  type        = number
  default     = 1
}

variable "event_hub_names" {
  description = "List of names of the eventhub resource. Chnaging this forces a new resource to be created.If enabled value is `Required`. "
  type        = list(string)
  default     = [null]
}

variable "event_hub_partititon_counts" {
  description = "List of current number of shards on event hub. Changing this forces a new resource to be created. If enabled value is `Required`."
  type        = list(number)
  default     = [2]
}

variable "event_hub_message_rententions" {
  description = "The list of number of days to retain the events for this eventhub. Needs to be between 1 and 7 days; or 1 day when using a `Basic` SKU for the parent eventhub namespace."
  type        = list(number)
  default     = [1]
}

variable "capture_description_enabled" {
  description = "Boolean flag list which specifies the capture description is enabled or not."
  type        = list(bool)
  default     = [false]
}

variable "capture_description_encoding" {
  description = "List of encoding used for the capture description. Possible values are `Avro` and `AvroDeflate`. Value is `Required` if `capture description` is enabled. "
  type        = list(string)
  default     = ["Avro"]
}

variable "capture_description_interval_in_seconds" {
  description = "List of time interval in seconds at which the capture will happen. Values can be between `60` and `900` seconds. Defaults to `300` seconds."
  type        = list(number)
  default     = [300]
}

variable "capture_description_size_in_bytes" {
  description = "List of amount of data built up in your EventHub before a Capture Operation occurs. Value should be between `10485760` and `524288000` bytes. Defaults to `314572800` bytes."
  type        = list(number)
  default     = [314572800]
}
