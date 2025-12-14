# CI/CD Pipeline Documentation

## Overview

This repository contains a complete CI/CD pipeline using GitHub Actions that automates the entire software delivery process from code commit to production deployment.

## Pipeline Stages

### Stage 1: Build & Test ✅
- **Purpose**: Compile the application and run automated tests
- **Actions**:
  - Checkout code
  - Setup Bun runtime
  - Install dependencies
  - Run unit/integration tests
  - Build Next.js application
  - Upload build artifacts

### Stage 2: Security & Linting 🔒
- **Purpose**: Ensure code quality and security
- **Actions**:
  - Run ESLint (code quality)
  - TypeScript type checking
  - Trivy vulnerability scanning
  - Upload security scan results

### Stage 3: Docker Build & Push 🐳
- **Purpose**: Create and publish containerized application
- **Actions**:
  - Setup Docker Buildx
  - Login to Docker Hub
  - Build Docker image
  - Push image to registry
  - Tag with version and SHA

### Stage 4: Terraform Apply 🏗️
- **Purpose**: Provision and configure infrastructure
- **Actions**:
  - Setup Terraform
  - Initialize Terraform
  - Validate configuration
  - Plan infrastructure changes
  - Apply infrastructure changes

### Stage 5: Ansible Deploy 📦
- **Purpose**: Deploy application to servers
- **Actions**:
  - Setup Ansible
  - Configure SSH access
  - Run Ansible playbook
  - Deploy application containers
  - Configure services

### Stage 6: Post-Deploy Smoke Tests 🧪
- **Purpose**: Verify deployment success
- **Actions**:
  - Wait for deployment to stabilize
  - Health check application
  - Test database connectivity
  - Verify API endpoints
  - Performance checks

## Required GitHub Secrets

Configure these secrets in your GitHub repository settings (Settings → Secrets and variables → Actions):

### Docker Hub
- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_PASSWORD`: Your Docker Hub password or access token

### Database
- `DATABASE_URL`: PostgreSQL connection string
- `POSTGRES_USER`: PostgreSQL username
- `POSTGRES_PASSWORD`: PostgreSQL password
- `POSTGRES_DB`: PostgreSQL database name

### Deployment
- `DEPLOY_HOST`: Target server IP or hostname (optional)
- `DEPLOY_SSH_KEY`: SSH private key for deployment server (optional)
- `DEPLOY_URL`: Application URL for smoke tests (default: http://localhost:3000)

## Pipeline Triggers

The pipeline runs on:
- **Push to main branch**: Full pipeline execution (all 6 stages)
- **Pull requests to main**: Build, test, and security checks only
- **Manual trigger**: Use "workflow_dispatch" to run manually

## Pipeline Flow

```
┌─────────────────┐
│  Code Push/PR   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Build & Test    │ ──┐
└────────┬────────┘   │
         │            │
         ▼            │
┌─────────────────┐   │
│ Security & Lint │ ──┤ (Parallel)
└────────┬────────┘   │
         │            │
         ▼            │
┌─────────────────┐   │
│ Docker Build    │ ──┘
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Terraform Apply │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Ansible Deploy  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Smoke Tests     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Pipeline Summary│
└─────────────────┘
```

## Viewing Pipeline Results

1. Go to your repository on GitHub
2. Click on the "Actions" tab
3. Select the workflow run you want to view
4. You'll see all stages with their status:
   - ✅ Green checkmark = Success
   - ⚠️ Yellow circle = Warning/Skipped
   - ❌ Red X = Failed

## Troubleshooting

### Pipeline Fails at Build Stage
- Check if all dependencies are correctly specified
- Verify test database connection
- Review build logs for specific errors

### Docker Build Fails
- Verify Docker Hub credentials are correct
- Check Dockerfile syntax
- Ensure build context is correct

### Ansible Deployment Fails
- Verify SSH keys are configured
- Check inventory file (host.ini)
- Ensure target server is accessible
- Review Ansible playbook logs

### Smoke Tests Fail
- Check if application is actually deployed
- Verify application URL is correct
- Check server logs for errors
- Ensure database is accessible

## Customization

### Adding More Tests
Edit the `build-and-test` job to add additional test commands.

### Adding Security Scans
Add more security tools in the `security-and-linting` job.

### Custom Infrastructure
Modify `terraform/main.tf` to provision your specific infrastructure.

### Custom Deployment
Update `ansible/playbook.yaml` to match your deployment requirements.

## Best Practices

1. **Never commit secrets**: Always use GitHub Secrets
2. **Test locally first**: Run tests before pushing
3. **Review pipeline logs**: Check each stage for issues
4. **Use branch protection**: Require pipeline success before merge
5. **Monitor deployments**: Set up alerts for failed deployments

## Screenshot Requirements

For assignment submission, capture:
1. **Pipeline Overview**: Shows all 6 stages
2. **Each Stage Detail**: Individual stage showing success
3. **Final Summary**: Pipeline summary with all stages passed

## Support

For issues or questions:
- Check GitHub Actions logs
- Review individual stage outputs
- Consult GitHub Actions documentation










