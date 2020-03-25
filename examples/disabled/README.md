## Disabled example

- This should not create any resource.

## Usage
```
terraform init
terraform plan
terraform apply
terraform destroy
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_id | Azure service principal application Id. | `string` | n/a | yes |
| client\_secret | Azure service principal application Secret. | `string` | n/a | yes |
| subscription\_id | Azure subscription Id. | `string` | n/a | yes |
| tenant\_id | Azure tenant Id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| consumer\_group\_ids | IDs of the eventhub consumer groups. |
| eventhub\_authorization\_rule\_ids | the IDs of the eventhub authorization rule. |
| evevent\_hub\_ids | the IDs of the eventhub. |
| namespace\_authorization\_rule\_ids | the IDs of the namespace authorization rule. |
| namespace\_id | The ID of the event hub namespace. |
| reovery\_namespace\_ids | IDs the disater recovery eventhub namespace. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
