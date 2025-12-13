# Ansible Configuration Management

This directory contains Ansible playbooks and configuration files for automating the deployment of the Next.js application.

## Files

- `playbook.yaml` - Main Ansible playbook that automates:
  - System package updates
  - Docker and Docker Compose installation
  - Application repository cloning/updating
  - Environment configuration and secrets deployment
  - Docker container deployment

- `host.ini` - Inventory file defining target hosts (configured for localhost)

- `ansible.cfg` - Ansible configuration file

## Prerequisites

1. **Install Ansible on your Ubuntu machine:**
   ```bash
   sudo apt update
   sudo apt install -y ansible
   ```

2. **Verify Ansible installation:**
   ```bash
   ansible --version
   ```

3. **Ensure you have sudo privileges** (the playbook requires root access for package installation)

## Usage

### For Local Ubuntu Machine

1. **Navigate to the ansible directory:**
   ```bash
   cd ansible
   ```

2. **Run the playbook:**
   ```bash
   ansible-playbook playbook.yaml
   ```

3. **Run with verbose output (for debugging):**
   ```bash
   ansible-playbook playbook.yaml -v
   ```

4. **Run with extra verbose output:**
   ```bash
   ansible-playbook playbook.yaml -vvv
   ```

### For Remote Servers

1. **Edit `host.ini`** and update with your server details:
   ```ini
   [web]
   server1 ansible_host=your_server_ip ansible_user=ubuntu
   ```

2. **Ensure SSH access is configured:**
   ```bash
   ssh-copy-id ubuntu@your_server_ip
   ```

3. **Run the playbook:**
   ```bash
   ansible-playbook playbook.yaml
   ```

## What the Playbook Does

1. **System Updates**: Updates and upgrades all system packages
2. **Dependencies Installation**: Installs required packages (curl, git, etc.)
3. **Docker Installation**: Installs Docker CE and Docker Compose
4. **Repository Management**: Clones or updates the application repository
5. **Configuration Deployment**: Creates `.env` file with database credentials and secrets
6. **Docker Deployment**: Builds and starts Docker containers (PostgreSQL + Next.js app)
7. **Verification**: Checks that containers are running and accessible

## Verification

After running the playbook, verify the deployment:

```bash
# Check running containers
docker ps

# Check application logs
docker logs nextjs-web

# Check database logs
docker logs nextjs-db

# Test the application
curl http://localhost:3000
```

## Troubleshooting

### WSL 2 Specific Issues

**If you see "docker command not found" in WSL 2:**

1. **Option A: Use Docker Desktop (Recommended)**
   - Install Docker Desktop for Windows
   - Enable WSL integration: Docker Desktop → Settings → Resources → WSL Integration
   - Enable your Ubuntu distribution
   - Restart WSL: `wsl --shutdown` (in PowerShell), then reopen terminal

2. **Option B: Install Docker in WSL 2**
   - Run the Ansible playbook (it installs Docker)
   - After installation, log out and back in, or run: `newgrp docker`
   - Start Docker service: `sudo service docker start`

3. **Check Docker setup:**
   ```bash
   chmod +x check-docker.sh
   ./check-docker.sh
   ```

### General Troubleshooting

1. **If you get permission errors:**
   - Ensure your user is in the sudo group: `groups`
   - You may need to run: `sudo usermod -aG sudo $USER`

2. **If Docker installation fails:**
   - Check internet connectivity
   - Verify Ubuntu version compatibility

3. **If containers fail to start:**
   - Check logs: `docker-compose -f /opt/nextjs-app/docker-compose.yml logs`
   - Verify .env file exists: `cat /opt/nextjs-app/.env`
   - Check if Docker is running: `sudo service docker status`

4. **For connection issues with remote hosts:**
   - Test SSH connection: `ssh ubuntu@your_server_ip`
   - Verify SSH key is added: `ssh-add -l`

5. **If playbook runs but containers don't start:**
   - Check if Docker is accessible: `docker ps` (may need `sudo docker ps`)
   - Verify containers were created: `docker ps -a`
   - Manually start containers: `cd /opt/nextjs-app && docker-compose up -d`

## Customization

You can customize the playbook by editing variables in `playbook.yaml`:

- `app_dir`: Directory where application will be deployed
- `postgres_user`: PostgreSQL username
- `postgres_password`: PostgreSQL password
- `postgres_db`: PostgreSQL database name
- `secret_key`: Application secret key
- `next_public_safe_key`: Public safe key

## Screenshot

After successful execution, take a screenshot of the terminal showing:
- The playbook execution output
- Container status verification
- Successful completion message

