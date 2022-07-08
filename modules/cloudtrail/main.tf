data "aws_caller_identity" "current" {}

locals {
  trail_name = "ksoc-discovery"
}

resource "random_id" "bucket_name" {
  byte_length = 16
}

resource "aws_cloudtrail" "ksoc_discovery" {
  name                          = local.trail_name
  s3_bucket_name                = aws_s3_bucket.ksoc_discovery.id
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = aws_kms_key.ksoc_discovery_key.arn
  event_selector {
    include_management_events        = "true"
    read_write_type                  = "WriteOnly"
    exclude_management_event_sources = ["kms.amazonaws.com", "rdsdata.amazonaws.com"]
  }
  sns_topic_name = aws_sns_topic.ksoc_discovery.name
}

resource "aws_s3_bucket" "ksoc_discovery" {
  bucket        = "${local.trail_name}-${random_id.bucket_name.hex}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "ksoc_discovery" {
  bucket = aws_s3_bucket.ksoc_discovery.id
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
            "Resource": "${aws_s3_bucket.ksoc_discovery.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.ksoc_discovery.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
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

resource "aws_kms_key" "ksoc_discovery_key" {
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
                    "AWS:SourceArn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}",
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

resource "aws_kms_alias" "ksoc_discovery_key_alias" {
  target_key_id = aws_kms_key.ksoc_discovery_key.id
  name          = "alias/${local.trail_name}"
}

resource "aws_sns_topic" "ksoc_discovery" {
  name   = local.trail_name
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
      "Resource": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${local.trail_name}",
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
      "Resource": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:${local.trail_name}",
      "Condition": {
        "StringLike": {
          "AWS:SourceArn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_lambda_function" "ksoc_discovery" {
  function_name = local.trail_name
  role          = aws_iam_role.ksoc_discovery_lambda.arn
  runtime       = "go1.x"
  handler       = "main"
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
    aws_iam_role_policy_attachment.ksoc_discovery,
    aws_cloudwatch_log_group.ksoc_discovery,
  ]
}

resource "aws_iam_role" "ksoc_discovery_lambda" {
  name               = local.trail_name
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

resource "aws_cloudwatch_log_group" "ksoc_discovery" {
  name              = "/aws/lambda/${local.trail_name}"
  retention_in_days = 7
}

resource "aws_iam_policy" "ksoc_discovery_lambda" {
  name        = "${local.trail_name}-lambda-logging"
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
        "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.trail_name}:*"
      ]
    },
    {
      "Sid": "KsocDiscoveryListBucket",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.ksoc_discovery.arn}"
      ]
    },
    {
      "Sid": "KsocDiscoveryGetObject",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.ksoc_discovery.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ksoc_discovery" {
  role       = aws_iam_role.ksoc_discovery_lambda.name
  policy_arn = aws_iam_policy.ksoc_discovery_lambda.arn
}

resource "aws_sns_topic_subscription" "ksoc_discovery" {
  endpoint  = aws_lambda_function.ksoc_discovery.arn
  protocol  = "lambda"
  topic_arn = aws_sns_topic.ksoc_discovery.arn
}

resource "aws_lambda_permission" "ksoc_discovery_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ksoc_discovery.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.ksoc_discovery.arn
}
