output "role_arn" {
  value       = aws_iam_role.ksoc_allow_discovery.arn
  description = "AWS IAM Role ARN to provide to KSOC to allow for resource discovery"
}
