# Infrastructure Setup - Step 2

This Terraform configuration provisions AWS infrastructure for the DevOps Lab project.

## Infrastructure Components

 **VPC + Subnets + Security Groups**
- Custom VPC with 10.0.0.0/16 CIDR
- 2 Public Subnets (for EC2 instances)
- 2 Private Subnets (for NAT)
- 2 Database Subnets (for RDS)
- Security groups for app server and database

 **EC2 Instance**
- Amazon Linux 2 instance with Docker pre-installed
- Public IP for SSH access
- Security group allowing SSH (22), HTTP (80), and Next.js (3000)

 **RDS PostgreSQL Database**
- PostgreSQL 15.3
- db.t3.micro instance (Free Tier eligible)
- 20GB storage
- Accessible from EC2 instances and VPC

 **S3 Bucket**
- Versioning enabled
- For persistent storage and backups

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **Terraform** installed (>= 1.5.0)
3. **AWS CLI** configured with credentials

## Setup AWS Credentials

### Option 1: Using AWS CLI (Recommended)
```powershell
aws configure
# Enter your AWS Access Key ID from eman_accessKeys.csv
# Enter your AWS Secret Access Key
# Enter region: ap-south-1
```

### Option 2: Environment Variables
```powershell
$env:AWS_ACCESS_KEY_ID="your_access_key"
$env:AWS_SECRET_ACCESS_KEY="your_secret_key"
$env:AWS_DEFAULT_REGION="ap-south-1"
```

### Option 3: Credentials File
Create `~/.aws/credentials`:
```ini
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
```

## Deployment Steps

### 1. Update Configuration
Edit `terraform.tfvars` and change the database password:
```hcl
db_password = "YourStrongPassword123!"
```

### 2. Initialize Terraform
```powershell
cd infra
terraform init
```

### 3. Validate Configuration
```powershell
terraform validate
```

### 4. Preview Changes
```powershell
terraform plan
```

### 5. Deploy Infrastructure
```powershell
terraform apply
```
Type `yes` when prompted.

### 6. View Outputs
```powershell
terraform output
```

This will show:
- VPC ID and subnets
- EC2 instance public IP
- RDS endpoint
- S3 bucket name
- SSH command

### 7. Get Sensitive Outputs
```powershell
# Database connection string
terraform output -raw connection_string

# Database password
terraform output -raw rds_password
```

## Verification (Step 2 Deliverables)

### ✅ Screenshot 1: Terraform Outputs
```powershell
terraform output
```
Take screenshot showing all provisioned resources.

### ✅ Screenshot 2: AWS Console - VPC
Go to AWS Console → VPC → Your VPCs
Show the created VPC with subnets and route tables.

### ✅ Screenshot 3: AWS Console - EC2
Go to AWS Console → EC2 → Instances
Show the running EC2 instance.

### ✅ Screenshot 4: AWS Console - RDS
Go to AWS Console → RDS → Databases
Show the PostgreSQL instance.

### ✅ Screenshot 5: AWS Console - S3
Go to AWS Console → S3 → Buckets
Show the created S3 bucket.

## Connect to EC2 Instance

```powershell
# Get SSH command from output
terraform output -raw ec2_ssh_command

# Or manually (replace IP)
ssh ec2-user@<EC2_PUBLIC_IP>
```

## Testing Database Connection

From EC2 instance:
```bash
# Install PostgreSQL client
sudo yum install -y postgresql

# Connect to RDS
psql -h <RDS_ENDPOINT> -U postgres -d nextjs_db
```

## Cleanup (terraform destroy)

⚠️ **IMPORTANT**: Take screenshots before destroying!

```powershell
cd infra
terraform destroy
```
Type `yes` when prompted.

### ✅ Screenshot 6: Terraform Destroy Proof
Take screenshot of successful destroy output.

## Cost Estimation

- **VPC/Subnets**: Free
- **EC2 t2.micro**: ~$8.50/month (Free Tier: 750hrs/month)
- **RDS db.t3.micro**: ~$15/month (Free Tier: 750hrs/month)
- **S3**: ~$0.023/GB (Free Tier: 5GB)
- **NAT Gateway**: ~$32/month (NOT Free Tier)

**Estimated Monthly Cost**: $40-60 (or ~$0.50-1/hour if running 24/7)

💡 **Tip**: Run `terraform destroy` when not actively using to save costs!

## Troubleshooting

### Error: "Error creating VPC"
- Check AWS credentials are configured correctly
- Verify IAM user has necessary permissions

### Error: "InvalidParameterValue: Invalid availability zones"
- Change region in `variables.tf` or `terraform.tfvars`
- Ensure region has at least 2 availability zones

### Error: "UnauthorizedOperation"
- Your AWS account may need additional permissions
- Contact AWS support or use admin credentials

### Error: "Resource already exists"
- Run `terraform destroy` to clean up
- Or change `project_name` in `terraform.tfvars`

## Next Steps

After infrastructure is provisioned:
1. ✅ Take all required screenshots
2. 📝 Document outputs in your report
3. 🐳 Proceed to Step 3: Containerization (Dockerfile & docker-compose)
4. 🎼 Proceed to Step 4: Ansible configuration
5. ☸️ Proceed to Step 5: Local Kubernetes deployment (Minikube/Docker Desktop)

## Files Structure
```
infra/
├── providers.tf       # AWS provider and Terraform config
├── variables.tf       # Input variables
├── terraform.tfvars   # Variable values (DO NOT COMMIT TO GIT!)
├── main.tf           # Infrastructure resources (VPC, EC2, RDS, S3)
├── outputs.tf        # Output values
└── README.md         # This file
```

## ⚠️ Security Notes

1. **Never commit terraform.tfvars to Git!** Add to `.gitignore`
2. **Never commit eman_accessKeys.csv to Git!**
3. Use strong passwords for RDS
4. Consider using AWS Secrets Manager for production
5. Restrict security group rules in production
