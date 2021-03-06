###
# General
###

variable "enabled" {
  description = "Enable or disable module."
  default     = true
}

variable "resource_group_name" {
  description = "Name of the resource group of the eventhub namespace resources should be exist.Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource."
  default     = {}
}

###
# Event-hub namespace
###

variable "event_hub_namespace_enabled" {
  description = "Boolean flag which describes whether or not enable the eventhub namespace."
  default     = false
}

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
  description = "Specifies the capacity/throughput units for a `Standard` SKU namespace. Valid values range from `1`-`20`."
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

variable "network_rulesets" {
  description = "One or more network rulesets.Network rulesets cannot be used be when sku is set to `Basic`"
  type        = list(object({ default_action = string, ip_mask = string, subnet_id = string, ignore_missing_virtual_network_service_endpoint = bool }))
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

variable "event_hub_namespace_exist" {
  description = "Boolean flag which describes whether the namespace is already existing or not."
  default     = false
}

variable "event_hub_existing_namespace_names" {
  description = "List of names of existing eventhub namespaces.Changing this forces a new resource to be created. If `event_hub_namespace_exist` enabled then value is `Required`."
  type        = list(string)
  default     = []
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

variable "event_hub_names" {
  description = "List of names of the eventhub resource. Chnaging this forces a new resource to be created.If enabled value is `Required`. "
  type        = list(string)
  default     = []
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

variable "destination_names" {
  description = "The list of names of  the Destination where the capture should take place. At this time the only supported value is `EventHubArchive.AzureBlockBlob`. If the `destination` is blocke is enabled value is `Required`."
  type        = list(string)
  default     = ["EventHubArchive.AzureBlockBlob"]
}

variable "destination_archive_name_formats" {
  description = "The list of The Blob naming convention for archiving. e.g. `{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}`. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order"
  type        = list(string)
  default     = [""]
}

variable "destination_blob_container_names" {
  description = "The list of names of the conatianers within the blob storage account where message should be archived. If the `destination` block is enabled this value is `Required`."
  type        = list(string)
  default     = [""]
}

variable "destination_storage_account_ids" {
  description = "The list of IDs of the blob storage account where messages should be archived.If the `destination` block is enabled this value is `Required`."
  type        = list(string)
  default     = [""]
}

###
# Event-hub authorization rules
###

variable "eventhub_authorization_rule_enabled" {
  description = "The boolean flag which describes whether to enable the authorization rule for the eventhub or not."
  type        = bool
  default     = false
}

variable "eventhub_authorization_rule_names" {
  description = "List of names of the eventhub authorization rule resource. Changing this forces a new resource to be created. If the rsource is enabled the Value is `Required`."
  type        = list(string)
  default     = [""]
}

variable "authorization_rule_event_hub_names" {
  description = "The list of names of the eventhubs to which this authorization rule will be associated. If enabled the value is `Requied`."
  type        = list(string)
  default     = [""]
}

variable "eventhub_authorization_rule_listens" {
  description = "List of boolean flag which describes the authorization rule have permissions to listen to eventhub? Defaults to `false`."
  type        = list(bool)
  default     = [false]
}

variable "eventhub_authorization_rule_sends" {
  description = "Boolean flag list which describes the does the authorization rule have permission to send to the eventhub? Default to `flase`."
  type        = list(string)
  default     = [false]
}

variable "eventhub_authorization_rule_manages" {
  description = "Boolean flag list which describes does this authorization rule have permission to manage to the event hub? when this property is `true`- both `listen` and `send` must be too. Default to `false`."
  type        = list(string)
  default     = [false]
}

###
# Event-hub consumer group
###

variable "consumer_group_enabled" {
  description = "Boolean flag which describes whether or not to enable the eventhub consumer group."
  type        = bool
  default     = false
}

variable "existing_event_hub_names" {
  description = "The list of names of existing eventhubs. Changing forces a new to be created."
  type        = list(string)
  default     = []
}


variable "consumer_group_names" {
  description = "List of names of the eventhub consumer group resource. Changing this forces a new resource to be created. If enabled value is `Required`."
  type        = list(string)
  default     = [""]
}

variable "consumer_group_event_hub_names" {
  description = "The list of names of the eventhub in which consumer groups will be created."
  type        = list(string)
  default     = [""]
}

variable "consumer_group_user_metadatas" {
  description = "List of user metadata."
  type        = list(string)
  default     = ["FX"]
}

###
# Event-hub namespace disaster recovery
###

variable "event_hub_namespace_recovery_enabled" {
  description = "Boolean flag which describes whether or not enable recovery config for eventhub namespace."
  default     = false
}

variable "event_hub_namespace_recovery_names" {
  description = "List of names of the disaster recovery config. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [null]
}

variable "event_hub_namesapce_disaster_recovery_exist" {
  description = "Boolean flag which the describes whether the eventhub namespace for which disaster recovery config will be setup already exist or not."
  default     = false
}

variable "event_hub_existing_namesapce_disaster_recovery_names" {
  description = "The list of names of existing eventhub namespace. Changing this will force a new recovery config to be cretaed. If `event_hub_namesapce_disaster_recovery_exist` is enabled then this value is `Required`."
  type        = list(string)
  default     = [""]
}


variable "event_hub_recovery_namespace_names" {
  description = "List of names of eventhub namespaces to which disaster recovery config is done.Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "event_hub_namespace_recovery_partner_namespace_ids" {
  description = "The list of IDs of the eventhub namespace to replicate to."
  type        = list(string)
  default     = [""]
}

variable "event_hub_namespace_alternate_names" {
  description = "List of alternate names to use when the diaster recovery config's name is the same as replicated namespace names."
  type        = list(string)
  default     = [""]
}
