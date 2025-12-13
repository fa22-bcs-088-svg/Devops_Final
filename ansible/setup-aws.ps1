# AWS Setup Script for Terraform Deployment
# Run this script to configure AWS credentials before running terraform

Write-Host "=== AWS Credentials Setup ===" -ForegroundColor Cyan
Write-Host ""

try {
    $awsVersion = aws --version 2>&1
    Write-Host " AWS CLI is installed: $awsVersion" -ForegroundColor Green
} catch {
    Write-Host " AWS CLI is not installed!" -ForegroundColor Red
    Write-Host "Please install AWS CLI from: https://aws.amazon.com/cli/" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Please enter your AWS credentials from eman_accessKeys.csv:" -ForegroundColor Yellow
Write-Host ""

$accessKey = Read-Host "AWS Access Key ID"
$secretKey = Read-Host "AWS Secret Access Key" -AsSecureString
$secretKeyPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secretKey))

# Configure AWS CLI
Write-Host ""
Write-Host "Configuring AWS CLI..." -ForegroundColor Cyan

# Set credentials using aws configure
$env:AWS_ACCESS_KEY_ID = $accessKey
$env:AWS_SECRET_ACCESS_KEY = $secretKeyPlain
$env:AWS_DEFAULT_REGION = "ap-south-1"

# Also configure using AWS CLI
aws configure set aws_access_key_id $accessKey
aws configure set aws_secret_access_key $secretKeyPlain
aws configure set default.region ap-south-1
aws configure set default.output json

Write-Host "✓ AWS credentials configured!" -ForegroundColor Green
Write-Host ""

# Test credentials
Write-Host "Testing AWS credentials..." -ForegroundColor Cyan
try {
    $identity = aws sts get-caller-identity 2>&1 | ConvertFrom-Json
    Write-Host "✓ Successfully authenticated as:" -ForegroundColor Green
    Write-Host "  Account: $($identity.Account)" -ForegroundColor White
    Write-Host "  User: $($identity.Arn)" -ForegroundColor White
} catch {
    Write-Host "✗ Failed to authenticate with AWS" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Next Steps ===" -ForegroundColor Cyan
Write-Host "1. Edit infra/terraform.tfvars and change the db_password"
Write-Host "2. Run: cd infra"
Write-Host "3. Run: terraform plan"
Write-Host "4. Run: terraform apply"
Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
