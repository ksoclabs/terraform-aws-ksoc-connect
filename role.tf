# Policy
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [local.ksoc_assumed_role_arn]
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

# Take the AWS readonly role
resource "aws_iam_role_policy_attachment" "readonly" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Instance profile
resource "aws_iam_instance_profile" "this" {
  name = aws_iam_role.this.name
  role = aws_iam_role.this.name
}

