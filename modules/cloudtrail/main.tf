data "aws_caller_identity" "current" {}

resource "random_id" "bucket_name" {
  byte_length = 16
}

locals {
  name = "ksoc-connect-cloudtrail"
}

resource "aws_cloudtrail" "cloudtrail" {
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = aws_kms_key.cloudtrail.arn
  name                          = local.name
  s3_bucket_name                = aws_s3_bucket.cloudtrail.id
  sns_topic_name                = aws_sns_topic.cloudtrail.name
  event_selector {
    exclude_management_event_sources = ["kms.amazonaws.com", "rdsdata.amazonaws.com"]
    include_management_events        = "true"
    read_write_type                  = "WriteOnly"
  }
}

resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${local.name}-${random_id.bucket_name.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.cloudtrail.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_kms_key" "cloudtrail" {
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Key policy created by CloudTrail",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
                ]
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow CloudTrail to encrypt logs",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "kms:GenerateDataKey*",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "AWS:SourceArn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/${local.name}",
                    "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
                }
            }
        },
        {
            "Sid": "Allow CloudTrail to describe key",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "kms:DescribeKey",
            "Resource": "*"
        },
        {
            "Sid": "Allow principals in the account to decrypt log files",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
                },
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
                }
            }
        },
        {
            "Sid": "Allow alias creation during setup",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "kms:CreateAlias",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
                },
                "StringLike": {
                    "kms:ViaService": "ec2.*.amazonaws.com"
                }
            }
        },
        {
            "Sid": "Enable cross account log decryption",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
                },
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_kms_alias" "cloudtrail" {
  target_key_id = aws_kms_key.cloudtrail.id
  name          = "alias/${local.name}"
}

resource "aws_sns_topic" "cloudtrail" {
  name   = local.name
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish"
      ],
      "Resource": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${local.name}",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "${data.aws_caller_identity.current.account_id}"
        }
      }
    },
    {
      "Sid": "AWSCloudTrailSNSPolicy20150319",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${local.name}",
      "Condition": {
        "StringLike": {
          "AWS:SourceArn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/${local.name}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_lambda_function" "cloudtrail" {
  function_name = local.name
  handler       = "main"
  role          = aws_iam_role.cloudtrail.arn
  runtime       = "go1.x"
  s3_bucket     = "ksoc-cloudtrail-observer"
  s3_key        = "ksoc-cloudtrail-observer.zip"
  environment {
    variables = {
      KSOC_COMPANY_ID : var.company_id
      KSOC_DEBUG : var.lambda_debug
      KSOC_INGEST_URL : var.ingest_url
      KSOC_TIMEOUT : var.lambda_timeout
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.cloudtrail,
    aws_cloudwatch_log_group.cloudtrail,
  ]
}

resource "aws_iam_role" "cloudtrail" {
  name               = local.name
  assume_role_policy = <<ASSUME_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
ASSUME_POLICY
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/lambda/${local.name}"
  retention_in_days = 7
}

resource "aws_iam_policy" "cloudtrail" {
  name        = "${local.name}-lambda-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:CreateLogGroup",
      "Resource": "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.name}:*"
      ]
    },
    {
      "Sid": "KsocDiscoveryListBucket",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.cloudtrail.arn}"
      ]
    },
    {
      "Sid": "KsocDiscoveryGetObject",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.cloudtrail.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cloudtrail" {
  role       = aws_iam_role.cloudtrail.name
  policy_arn = aws_iam_policy.cloudtrail.arn
}

resource "aws_sns_topic_subscription" "cloudtrail" {
  endpoint  = aws_lambda_function.cloudtrail.arn
  protocol  = "lambda"
  topic_arn = aws_sns_topic.cloudtrail.arn
}

resource "aws_lambda_permission" "cloudtrail" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudtrail.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.cloudtrail.arn
}
