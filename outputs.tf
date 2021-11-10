output "role_arn" {
  value       = aws_iam_role.ksoc_connect.arn
  description = "AWS IAM Role ARN to provide to KSOC to allow connection"
}
