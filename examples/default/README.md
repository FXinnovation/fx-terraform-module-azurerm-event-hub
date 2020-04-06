## Default example

- This should create few resources related to the event hub.

## Usage
```
terraform init
terraform plan
terraform apply
terraform destroy
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.0.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_id | Azure service principal application Id. | `string` | n/a | yes |
| client\_secret | Azure service principal application Secret. | `string` | n/a | yes |
| subscription\_id | Azure subscription Id. | `string` | n/a | yes |
| tenant\_id | Azure tenant Id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| consumer\_group\_ids | IDs of the eventhub consumer groups. |
| eventhub\_authorization\_rule\_ids | The IDs of the eventhub authorization rule. |
| evevent\_hub\_ids | The IDs of the eventhub. |
| namespace\_authorization\_rule\_ids | The IDs of the namespace authorization rule. |
| namespace\_id | The ID of the event hub namespace. |
| reovery\_namespace\_ids | IDs the disater recovery eventhub namespace. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
