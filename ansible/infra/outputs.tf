## ----------------------------------------------------
## Infrastructure Outputs for Step 2
## ----------------------------------------------------

output "vpc_id" {
  description = "The ID of the provisioned VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "ec2_instance_id" {
  description = "EC2 instance ID for app server"
  value       = aws_instance.app_server.id
}

output "ec2_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "ec2_ssh_command" {
  description = "SSH command to connect to EC2 instance"
  value       = "ssh ec2-user@${aws_instance.app_server.public_ip}"
}

output "rds_endpoint" {
  description = "The database endpoint to connect your application"
  value       = module.db.db_instance_address
}

output "rds_port" {
  description = "The database port"
  value       = module.db.db_instance_port
}

output "rds_database_name" {
  description = "The database name"
  value       = module.db.db_instance_name
}

output "rds_username" {
  description = "The database master username"
  value       = module.db.db_instance_username
  sensitive   = true
}

output "rds_password" {
  description = "The database master password (sensitive)"
  value       = var.db_password
  sensitive   = true
}

output "s3_bucket_name" {
  description = "S3 bucket name for persistent storage"
  value       = aws_s3_bucket.app_storage.id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.app_storage.arn
}

output "connection_string" {
  description = "PostgreSQL connection string for application"
  value       = "postgresql://${module.db.db_instance_username}:${var.db_password}@${module.db.db_instance_address}:${module.db.db_instance_port}/${module.db.db_instance_name}"
  sensitive   = true
}