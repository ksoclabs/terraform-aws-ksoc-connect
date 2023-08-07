output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "AWS IAM Role ARN which Ksoc uses to connect"
}
