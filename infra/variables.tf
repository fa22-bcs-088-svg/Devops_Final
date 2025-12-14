variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "nextjs-devops"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "db_password" {
  description = "Postgres password"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Postgres username"
  type        = string
  default     = "myuser"
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
  default     = "mydatabase"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "bucket_name_override" {
  description = "Optional S3 bucket name override"
  type        = string
  default     = null
}

# Optional EKS toggle and settings
variable "enable_eks" {
  description = "Set to true to provision EKS cluster and a minimal node group"
  type        = bool
  default     = false
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "nextjs-devops-eks"
}

variable "eks_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.29"
}