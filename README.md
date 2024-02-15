# terraform-aws-ksoc-connect

The module allows you to connect your AWS account to KSOC to allow them to be able to scan and analyze your AWS resources.

## Terraform Registry

This module is available in the [Terraform Registry](https://registry.terraform.io/) see [here](https://registry.terraform.io/modules/ksoclabs/ksoc-connect/aws/latest). It uses the official KSOC Provider to authenticate and connect your AWS account to KSOC. The KSOC Provider can be found here in the [Terraform Provider Registry](https://registry.terraform.io/providers/ksoclabs/ksoc/latest).

## Contributing

The most important thing to be aware of when contributing is that we leverage the [Semantic Release Action](https://github.com/cycjimmy/semantic-release-action) to automate our changelog, see [here](CHANGELOG.md).

This requires us to use [conventional git commits](https://www.conventionalcommits.org/en/v1.0.0/) when committing to this repository.

Each PR merge into the `main` branch will execute the release process defined [here](.github/workflows/release.yml).

## Usage

This module requires you to obtain a set of cloud API credentials from KSOC (access_key/secret). It will use those credentials to connect your AWS account to your KSOC account.

The module needs an AWS provider to be configured. It will create an IAM Role called `ksoc-connect`. The IAM Role has the AWS default `ReadOnlyAccess` policy attached. The Role allows `ksoc-connector` in KSOC's AWS account to assume the role.

When the `ksoc-connect` Role is created, it will be added to your KSOC account through the `ksoc_aws_register` resource.

There is an optional flag `enable_eks_audit_logs_pipeline` which will create a CloudWatch Logs -> FireHose -> S3 pipeline for all EKS clusters in the account. This is required for KSOC to be able to analyse EKS audit logs. Make sure to enable EKS audit logs for EKS clusters you wish to be analysed.

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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_subscription_filter.subscription_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.ksoc_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ksoc_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ksoc_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kinesis_firehose_delivery_stream.firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_s3_bucket.audit_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [ksoc_aws_register.this](https://registry.terraform.io/providers/ksoclabs/ksoc/latest/docs/resources/aws_register) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_groups.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_groups) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.firehose_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ksoc_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ksoc_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logs_to_firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_eks_audit_logs_pipeline"></a> [enable\_eks\_audit\_logs\_pipeline](#input\_enable\_eks\_audit\_logs\_pipeline) | Enable EKS Audit Logs Pipeline (CloudWatch Logs -> FireHose -> S3) | `bool` | `false` | no |
| <a name="input_ksoc_assumed_role_arn"></a> [ksoc\_assumed\_role\_arn](#input\_ksoc\_assumed\_role\_arn) | KSOC Role that will be allowed to assume | `string` | `"arn:aws:iam::955322216602:role/ksoc-connector"` | no |
| <a name="input_ksoc_eks_audit_logs_assumed_role_arn"></a> [ksoc\_eks\_audit\_logs\_assumed\_role\_arn](#input\_ksoc\_eks\_audit\_logs\_assumed\_role\_arn) | KSOC Role dedicated for EKS audit logs that will be allowed to assume | `string` | `"arn:aws:iam::955322216602:role/ksoc-data-pipeline"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | AWS IAM Role ARN which Ksoc uses to connect |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.
