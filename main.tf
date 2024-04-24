# Policy
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.ksoc_assumed_role_arn]
    }
  }
}

# Role
resource "aws_iam_role" "this" {
  name                 = "ksoc-connect"
  path                 = "/"
  max_session_duration = 3600
  description          = "IAM role for ksoc-connect"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Instance profile
resource "aws_iam_instance_profile" "this" {
  name = aws_iam_role.this.name
  role = aws_iam_role.this.name
}

resource "ksoc_aws_register" "this" {
  ksoc_assumed_role_arn = var.ksoc_assumed_role_arn
  aws_account_id        = data.aws_caller_identity.current.account_id
}
