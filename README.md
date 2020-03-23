# terraform-module-azurerm-event-hub

## Usage
See `examples` folders for usage of this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.36.0, < 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| authorization\_rule\_event\_hub\_names | The list of names of the eventhubs to which this authorization rule will be associated. If enabled the value is `Requied`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| capture\_description\_enabled | Boolean flag list which specifies the capture description is enabled or not. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| capture\_description\_encoding | List of encoding used for the capture description. Possible values are `Avro` and `AvroDeflate`. Value is `Required` if `capture description` is enabled. | `list(string)` | <pre>[<br>  "Avro"<br>]</pre> | no |
| capture\_description\_interval\_in\_seconds | List of time interval in seconds at which the capture will happen. Values can be between `60` and `900` seconds. Defaults to `300` seconds. | `list(number)` | <pre>[<br>  300<br>]</pre> | no |
| capture\_description\_size\_in\_bytes | List of amount of data built up in your EventHub before a Capture Operation occurs. Value should be between `10485760` and `524288000` bytes. Defaults to `314572800` bytes. | `list(number)` | <pre>[<br>  314572800<br>]</pre> | no |
| consumer\_group\_enabled | Boolean flag which describes whether or not to enable the eventhub consumer group. | `bool` | `false` | no |
| consumer\_group\_event\_hub\_names | The list of names of the eventhub in which consumer groups will be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| consumer\_group\_names | List of names of the eventhub consumer group resource. Changing this forces a new resource to be created. If enabled value is `Required`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| consumer\_group\_user\_metadatas | List of user metadata. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| destination\_archive\_name\_formats | The list of The Blob naming convention for archiving. e.g. `{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}`. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| destination\_blob\_container\_names | The list of names of the conatianers within the blob storage account where message should be archived. If the `destination` block is enabled this value is `Required`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| destination\_names | The list of names of  the Destination where the capture should take place. At this time the only supported value is `EventHubArchive.AzureBlockBlob`. If the `destination` is blocke is enabled value is `Required`. | `list(string)` | <pre>[<br>  "EventHubArchive.AzureBlockBlob"<br>]</pre> | no |
| destination\_storage\_account\_ids | The list of IDs of the blob storage account where messages should be archived.If the `destination` block is enabled this value is `Required`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| enabled | Enable or diasble module. | `bool` | `true` | no |
| event\_hub\_count | The number of eventhun which will be deployed using this module. If enabled value is `Required`. | `number` | `1` | no |
| event\_hub\_enabled | Boolean flag which describes whether to enable the eventub resource or not. | `bool` | `false` | no |
| event\_hub\_message\_rententions | The list of number of days to retain the events for this eventhub. Needs to be between 1 and 7 days; or 1 day when using a `Basic` SKU for the parent eventhub namespace. | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| event\_hub\_names | List of names of the eventhub resource. Chnaging this forces a new resource to be created.If enabled value is `Required`. | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| event\_hub\_namespace\_enabled | Boolean flag which describes whether or not enable the eventhub namespace. | `bool` | `false` | no |
| event\_hub\_partititon\_counts | List of current number of shards on event hub. Changing this forces a new resource to be created. If enabled value is `Required`. | `list(number)` | <pre>[<br>  2<br>]</pre> | no |
| eventhub\_authorization\_rule\_enabled | The boolean flag which describes whether to enable the authorization rule for the eventhub or not. | `bool` | `false` | no |
| eventhub\_authorization\_rule\_listen | List of boolean flag which describes the authorization rule have permissions to listen to eventhub? Defaults to `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| eventhub\_authorization\_rule\_manages | Boolean flag list which describes does this authorization rule have permission to manage to the event hub? when this property is `true`- both `listen` and `send` must be too. Default to `false`. | `list(string)` | <pre>[<br>  false<br>]</pre> | no |
| eventhub\_authorization\_rule\_names | List of names of the eventhub authorization rule resource. Changing this forces a new resource to be created. If the rsource is enabled the Value is `Required`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| eventhub\_authorization\_rule\_sends | Boolean flag list which describes the does the authorization rule have permission to send to the eventhub? Default to `flase`. | `list(string)` | <pre>[<br>  false<br>]</pre> | no |
| eventhub\_namespace\_auto\_inflate\_enabled | Boolean flag which describes whether the auto inflate enabled for the eventhub namespace. | `bool` | `false` | no |
| eventhub\_namespace\_capacitiy | Specifies the capacity / throughput units for a `Standard` SKU namespace. Valid values range from `1`-`20`. | `number` | `5` | no |
| eventhub\_namespace\_location | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. If enabled value is `REQUIRED`. | `string` | `""` | no |
| eventhub\_namespace\_maximum\_throughput\_units | Specifies the maximum number of throughput units when auto inflate is enabled. Valid values range from `1`-`20`. | `number` | `5` | no |
| eventhub\_namespace\_name | Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created. If enabled values is `REQUIRED`. | `string` | `""` | no |
| eventhub\_namespace\_sku | Defines which tier to use. Valid options are `Basic` and `Standard`. If enabled value is `REQUIRED`. | `string` | `"Basic"` | no |
| eventhub\_namespace\_tags | Tags which will be associated to the eventhub namespace. | `map` | `{}` | no |
| namespace\_authorization\_rule\_enabled | Boolean flag which describes whether to enable the namespace authorization rules or not. | `bool` | `false` | no |
| namespace\_authorization\_rule\_listens | The list of boolean flags which describes whether to grant listen access to authorization rule. Defaults to `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| namespace\_authorization\_rule\_manages | The list of boolean flags which describes whether to grant send access to authorization rule.When this property is `ture` both `listen` and `send` must be too. Defaults to `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| namespace\_authorization\_rule\_names | The list which specifies the names of the authorization rule. Changing this forces a new resourece to be created. If enabled value is `Required`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| namespace\_authorization\_rule\_sends | The list of boolean flags which describes whether to grant send access to authorization rule. Defaults to `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| network\_rules | Network rules restricing access to the event hub. | `object({ ip_rules = list(string), subnet_ids = list(string) })` | n/a | yes |
| resource\_group\_name | Name of the resource group of the eventhub namespace resources should be exist.Changing this forces a new resource to be created. | `string` | n/a | yes |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| eventhub\_namespace\_id | The ID of the event hub namespace. |
| namesapce\_authorization\_rule\_ids | IDs of the namespace authorization rules. |
| namesapce\_authorization\_rule\_primary\_connection string | The primary connection string for the authorization rules. |
| namesapce\_authorization\_rule\_primary\_key | The primary keys for the authorization rules. |
| namesapce\_authorization\_rule\_secondary\_connection string | The secondary connection string for the authorization rules. |
| namesapce\_authorization\_rule\_secondary\_key | The secondary keys for the authorization rules. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
