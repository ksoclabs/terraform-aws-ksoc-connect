data "aws_iam_policy_document" "ksoc_connect_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.ksoc_role_arn]
    }
  }
}

data "aws_iam_policy_document" "ksoc_connect" {
  statement {
    actions = [
      "ecr:Describe*", #tfsec:ignore:AWS099
      "ecr:Get*",      #tfsec:ignore:AWS099
      "ecr:List*",     #tfsec:ignore:AWS099
    ]
    effect    = "Allow"
    resources = ["*"] #tfsec:ignore:AWS099
  }

  statement {
    actions = [
      "ecs:Describe*", #tfsec:ignore:AWS099
      "ecs:List*",     #tfsec:ignore:AWS099
    ]
    effect    = "Allow"
    resources = ["*"] #tfsec:ignore:AWS099
  }

  statement {
    actions = [
      "eks:Describe*", #tfsec:ignore:AWS099
      "eks:List*",     #tfsec:ignore:AWS099
    ]
    effect    = "Allow"
    resources = ["*"] #tfsec:ignore:AWS099
  }
}

resource "aws_iam_role" "ksoc_connect" {
  name                  = "ksoc-connect"
  force_detach_policies = "true"
  assume_role_policy    = data.aws_iam_policy_document.ksoc_connect_assume_role_policy.json
}

resource "aws_iam_policy" "ksoc_connect" {
  name   = "ksoc-connect-${data.aws_region.current.name}"
  path   = "/"
  policy = data.aws_iam_policy_document.ksoc_connect.json
}

resource "aws_iam_role_policy_attachment" "ksoc_connect" {
  role       = aws_iam_role.ksoc_connect.id
  policy_arn = aws_iam_policy.ksoc_connect.arn
}

module "cloudtrail" {
  source           = "./modules/cloudtrail"
  company_id       = var.company_id
  count            = var.cloudtrail_enabled ? 1 : 0
  ingest_url       = var.ingest_url
  resources_prefix = var.cloudtrail_resources_prefix
}
