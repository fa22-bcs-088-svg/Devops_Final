# DATABASE_URL Setup Guide

## What is DATABASE_URL?

`DATABASE_URL` is a PostgreSQL connection string that tells your application how to connect to the database. It follows this format:

```
postgresql://username:password@host:port/database_name
```

## Where to Get DATABASE_URL

### Option 1: For Local Development

If you're running locally with Docker Compose, the DATABASE_URL is automatically set in the `.env` file:

```bash
DATABASE_URL=postgres://myuser:mypassword@db:5432/mydatabase
```

### Option 2: For CI/CD Pipeline (GitHub Actions)

You need to set it as a **GitHub Secret**:

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `DATABASE_URL`
5. Value: Your PostgreSQL connection string

#### Example DATABASE_URL Values:

**For Docker Compose (internal):**
```
postgresql://myuser:mypassword@db:5432/mydatabase
```

**For External Database:**
```
postgresql://username:password@your-db-host.com:5432/database_name
```

**For Local Testing (CI/CD):**
```
postgresql://test_user:test_password@localhost:5432/test_db
```

### Option 3: For Production Deployment

If deploying to a cloud provider:

**AWS RDS:**
```
postgresql://username:password@your-rds-endpoint.region.rds.amazonaws.com:5432/dbname
```

**DigitalOcean:**
```
postgresql://username:password@your-db-host.db.ondigitalocean.com:25060/dbname?sslmode=require
```

**Heroku:**
```
postgresql://user:pass@host:5432/dbname
```

## How to Set Up in GitHub Secrets

### Step-by-Step:

1. **Go to your repository on GitHub**
   - Navigate to: `https://github.com/your-username/next-self-host`

2. **Open Settings**
   - Click on **Settings** tab (top menu)

3. **Go to Secrets**
   - Click **Secrets and variables** → **Actions** (left sidebar)

4. **Add New Secret**
   - Click **New repository secret** button

5. **Enter Secret Details**
   - **Name**: `DATABASE_URL`
   - **Value**: Your connection string (see examples above)
   - Click **Add secret**

6. **Verify**
   - You should see `DATABASE_URL` in your secrets list

## Default/Placeholder DATABASE_URL

If you don't set the secret, the pipeline will use a placeholder:
```
postgresql://build_user:build_password@build_host:5432/build_db
```

**Note**: This placeholder works for building the Docker image, but you'll need a real DATABASE_URL at runtime when the application runs.

## Where DATABASE_URL is Used

### 1. **Dockerfile** (Build Time)
```dockerfile
ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL
```
- Needed during `bun run build` to collect page data

### 2. **docker-compose.yml** (Runtime)
```yaml
environment:
  DATABASE_URL: ${DATABASE_URL}
```
- Used when containers are running

### 3. **Ansible Playbook** (Deployment)
```yaml
DATABASE_URL: "postgres://{{ postgres_user }}:{{ postgres_password }}@db:5432/{{ postgres_db }}"
```
- Creates the connection string during deployment

### 4. **Application Code** (`app/db/drizzle.ts`)
```typescript
const client = postgres(process.env.DATABASE_URL);
```
- Used to connect to the database at runtime

## Quick Setup for CI/CD

### Minimum Required Secret:

For the CI/CD pipeline to work, you need at least:

```
DATABASE_URL=postgresql://test_user:test_password@localhost:5432/test_db
```

This is used during the Docker build process. The actual runtime DATABASE_URL will be set by your deployment configuration (Ansible, docker-compose, etc.).

## Testing Your DATABASE_URL

### Test Connection String Format:
```bash
# Format: postgresql://user:pass@host:port/db
postgresql://myuser:mypassword@localhost:5432/mydatabase
```

### Verify in Code:
The connection string should:
- Start with `postgresql://` or `postgres://`
- Include username and password
- Include host (can be `localhost`, `db`, or an IP/domain)
- Include port (usually `5432`)
- Include database name

## Troubleshooting

### Error: "DATABASE_URL environment variable is not set"

**Solution 1**: Add it to GitHub Secrets
- Go to Settings → Secrets → Actions
- Add `DATABASE_URL` secret

**Solution 2**: The build will use a placeholder
- The updated code now handles missing DATABASE_URL during build
- Make sure to set it properly at runtime

### Error: "Connection refused" or "Cannot connect"

**Check**:
1. Database is running
2. Host/port is correct
3. Username/password are correct
4. Database name exists
5. Network/firewall allows connection

## Security Notes

⚠️ **Never commit DATABASE_URL to code!**
- Always use secrets/environment variables
- Use different URLs for dev/staging/production
- Rotate passwords regularly

## Summary

1. **For CI/CD**: Set `DATABASE_URL` in GitHub Secrets
2. **For Local**: Use `.env` file (already configured)
3. **For Production**: Set in deployment configuration (Ansible/docker-compose)
4. **Format**: `postgresql://user:pass@host:port/dbname`

---

**Quick Fix**: If you just want the build to work, the pipeline now uses a placeholder if the secret is missing. But for proper functionality, set the `DATABASE_URL` secret in GitHub!


