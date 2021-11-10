# terraform-aws-ksoc-connect

Allows KSOC to connect to your AWS account to perform EKS/ECS/ECR discovery and perform pro-active monitoring of these resources.

## Usage

During sign-up, you will have been provided with an AWS IAM Role ARN - this should be passed into the module using the `ksoc_role_arn` variable:

``` terraform
module ksoc_connect {
  ksoc_role_arn = "arn:aws:iam::EXAMPLE:role/EXAMPLE"
}
```

Once applied, the module will then output a newly-created AWS IAM Role ARN in your account. This should be provided to KSOC to complete the connection process.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.62.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ksoc_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ksoc_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ksoc_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.ksoc_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ksoc_connect_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ksoc_role_arn"></a> [ksoc\_role\_arn](#input\_ksoc\_role\_arn) | AWS IAM Role ARN provided by KSOC for connection | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | AWS IAM Role ARN to provide to KSOC to allow connection |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
