# Next Steps - Deploy Next.js Application

## ✅ Docker is Working!

You've successfully fixed Docker Desktop WSL integration. Now let's deploy your Next.js application.

## Step 1: Run the Ansible Playbook

Navigate to the ansible directory and run the playbook:

```bash
cd ~/path/to/next-self-host/ansible
# Or if you're already in the project:
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible

./run-playbook.sh
```

The playbook will:
- Install/update system packages
- Install Docker (if not already installed)
- Clone/update the application repository
- Create configuration files (.env)
- Build and start Docker containers

## Step 2: Verify Deployment

After the playbook completes successfully:

```bash
# Check if Next.js containers are running
docker ps | grep nextjs

# Should show:
# - nextjs-db (PostgreSQL)
# - nextjs-web (Next.js app)
```

## Step 3: Test the Application

```bash
# Test the Next.js application
curl http://localhost:3000

# Or open in browser:
# http://localhost:3000
```

## If Containers Already Exist

If the playbook was run before but containers aren't running:

```bash
# Navigate to app directory
cd /opt/nextjs-app

# Start containers
docker-compose up -d

# Check status
docker-compose ps
```

## Troubleshooting

### If playbook fails:
- Check for errors in the output
- Run with verbose mode: `./run-playbook.sh -v`

### If containers don't start:
- Check logs: `docker-compose -f /opt/nextjs-app/docker-compose.yml logs`
- Verify .env exists: `cat /opt/nextjs-app/.env`

### Port 3000 already in use:
If you see port conflict (your node_app is using port 3000):
- Stop the existing container: `docker stop node_app`
- Or change the port in docker-compose.yml



