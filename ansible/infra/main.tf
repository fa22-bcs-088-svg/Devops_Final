## ----------------------------------------------------
## 1. VPC, Subnets, and Networking
## ----------------------------------------------------
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  # Deploy across 2 Availability Zones
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  
  tags = {
    Project = var.project_name
  }
}

## ----------------------------------------------------
## 2. EC2 Instance Security Group
## ----------------------------------------------------
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-app-sg"
  description = "Security group for application EC2 instances"
  vpc_id      = module.vpc.vpc_id

  # SSH access
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # App port (Next.js default 3000)
  ingress {
    description = "Next.js app"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-app-sg"
    Project = var.project_name
  }
}

## ----------------------------------------------------
## 3. EC2 Instances (for Docker/App hosting)
## ----------------------------------------------------
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name      = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              EOF

  tags = {
    Name    = "${var.project_name}-app-server"
    Project = var.project_name
  }
}

## ----------------------------------------------------
## 4. RDS PostgreSQL Database Security Group
## ----------------------------------------------------
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = module.vpc.vpc_id

  # Allow EC2 app servers to connect
  ingress {
    description     = "PostgreSQL from app servers"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # Allow from VPC CIDR (for local K8s access via VPN/tunnel)
  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-rds-sg"
    Project = var.project_name
  }
}

## ----------------------------------------------------
## 5. RDS PostgreSQL Database Instance
## ----------------------------------------------------
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.4.0"

  identifier           = "${var.project_name}-postgres"
  engine               = "postgres"
  engine_version       = "16.11"
  family               = "postgres16"
  instance_class       = var.db_instance_class
  allocated_storage    = 20
  skip_final_snapshot  = true
  publicly_accessible  = false
  create_db_subnet_group = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  
  # Credentials and DB Name
  username             = "postgres"
  password             = var.db_password
  db_name              = "nextjs_db"

  # Networking
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  subnet_ids             = module.vpc.database_subnets
  multi_az               = false
  
  tags = {
    Project = var.project_name
  }
}

## ----------------------------------------------------
## 6. S3 Bucket (for persistent storage)
## ----------------------------------------------------
resource "aws_s3_bucket" "app_storage" {
  bucket = "${var.project_name}-storage-${random_string.suffix.result}"

  tags = {
    Name    = "${var.project_name}-storage"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}