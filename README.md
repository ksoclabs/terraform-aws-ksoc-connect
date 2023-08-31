# terraform-aws-ksoc-connect

Allows KSOC to connect to your AWS account to KSOC to be able to scan and anyalize your AWS resources.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/ksoclabs/ksoc-connect/aws/latest). It uses the official KSOC Provider to authenticate and Add an AWS account to your KSOC account. The KSOC Provider can be found here in the [Terraform Provider Registry](https://registry.terraform.io/providers/ksoclabs/ksoc/latest).

## Contributing

The most important thing to be aware of when contributing is that we leverage the [Semantic Release Action](https://github.com/cycjimmy/semantic-release-action) to automate our changelog, see [here](CHANGELOG.md).

This requires us to use [conventional git commits](https://www.conventionalcommits.org/en/v1.0.0/) when committing to this repository.

Each PR merge into the `main` branch will execute the release process defined [here](.github/workflows/release.yml).

## Usage

This module requires you to obtain a set of cloud API credentials from KSOC (access_key/secret). It will use those credentials to connect your AWS account to your KSOC account.

The module needs an AWS provider to be configured. It will create an IAM Role called `ksoc-connect`. The IAM Role has the AWS default `ReadOnlyAccess` policy attached. The Role allows `ksoc-connector` in KSOC's AWS account to assume the role.

When the `ksoc-connect` Role is created, it will be added to your KSOC account through the `ksoc_aws_register` resource.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.62.0 |
| <a name="requirement_ksoc"></a> [ksoc](#requirement\_ksoc) | >= 0.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.62.0 |
| <a name="provider_ksoc"></a> [ksoc](#provider\_ksoc) | >= 0.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [ksoc_aws_register.this](https://registry.terraform.io/providers/ksoclabs/ksoc/latest/docs/resources/aws_register) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ksoc_assumed_role_arn"></a> [ksoc\_assumed\_role\_arn](#input\_ksoc\_assumed\_role\_arn) | KSOC Role that will be allowed to assume | `string` | `"arn:aws:iam::955322216602:role/ksoc-connector"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | AWS IAM Role ARN which Ksoc uses to connect |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
