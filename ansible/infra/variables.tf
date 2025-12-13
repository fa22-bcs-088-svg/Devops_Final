variable "aws_region" {
  description = "The AWS region to deploy all resources into."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "A prefix used to name all resources."
  type        = string
  default     = "nextjs-devops"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "The password for the RDS PostgreSQL database. (Required and must be set via env var or tfvars)"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance type for the RDS database."
  type        = string
  default     = "db.t3.micro"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type for the application server."
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instance access."
  type        = string
  default     = ""
}