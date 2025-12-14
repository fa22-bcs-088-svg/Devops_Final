output "ec2_public_ip" {
  value       = aws_instance.app.public_ip
  description = "Public IP of the EC2 instance"
}

output "rds_endpoint" {
  value       = aws_db_instance.postgres.address
  description = "Endpoint of the Postgres instance"
}

output "s3_bucket" {
  value       = aws_s3_bucket.app_bucket.bucket
  description = "Created S3 bucket name"
}

# Optional EKS outputs (null when disabled)
output "eks_cluster_name" {
  value       = try(aws_eks_cluster.cluster[0].name, null)
  description = "EKS cluster name (if enabled)"
}

output "eks_cluster_endpoint" {
  value       = try(aws_eks_cluster.cluster[0].endpoint, null)
  description = "EKS API endpoint (if enabled)"
}

output "eks_cluster_ca" {
  value       = try(aws_eks_cluster.cluster[0].certificate_authority[0].data, null)
  description = "EKS cluster CA certificate (if enabled)"
}

# Helpful networking outputs
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "IDs of public subnets"
}

output "ec2_security_group_id" {
  value       = aws_security_group.ec2.id
  description = "Security Group ID for EC2"
}

output "rds_security_group_id" {
  value       = aws_security_group.rds.id
  description = "Security Group ID for RDS"
}

# Additional instance details
output "ec2_instance_id" {
  value       = aws_instance.app.id
  description = "EC2 instance ID"
}

output "ec2_ami" {
  value       = aws_instance.app.ami
  description = "AMI ID used by EC2"
}

output "ec2_az" {
  value       = aws_instance.app.availability_zone
  description = "Availability Zone of EC2"
}

# RDS connection details (no secrets)
output "rds_hostname" {
  value       = aws_db_instance.postgres.address
  description = "RDS hostname"
}

output "rds_port" {
  value       = aws_db_instance.postgres.port
  description = "RDS port"
}

output "rds_username" {
  value       = var.db_username
  description = "RDS master username"
}

output "rds_db_name" {
  value       = var.db_name
  description = "RDS database name"
}

# S3 details
output "s3_bucket_arn" {
  value       = aws_s3_bucket.app_bucket.arn
  description = "S3 bucket ARN"
}