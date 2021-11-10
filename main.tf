# ==================================================================
# This is the IAM role that the discovery processor will assume
# in any given account to discovery the needful.
# ==================================================================

data "aws_iam_policy_document" "ksoc_allow_discovery_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [var.ksoc_role_arn]
    }
  }
}

data "aws_iam_policy_document" "ksoc_allow_discovery" {
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

resource "aws_iam_role" "ksoc_allow_discovery" {
  name                  = "ksoc-allow-discovery"
  force_detach_policies = "true"
  assume_role_policy    = data.aws_iam_policy_document.ksoc_allow_discovery_assume_role_policy.json
}

resource "aws_iam_policy" "ksoc_allow_discovery" {
  name   = "ksoc-allow-discovery-${data.aws_region.current.name}"
  path   = "/"
  policy = data.aws_iam_policy_document.ksoc_allow_discovery.json
}

resource "aws_iam_role_policy_attachment" "ksoc_allow_discovery" {
  role       = aws_iam_role.ksoc_allow_discovery.id
  policy_arn = aws_iam_policy.ksoc_allow_discovery.arn
}
