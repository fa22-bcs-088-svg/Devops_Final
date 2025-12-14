# Docker Setup for WSL 2

## Problem
Docker commands are not available in WSL 2, showing the error:
```
The command 'docker' could not be found in this WSL 2 distro.
```

## Solution Options

### Option 1: Use Docker Desktop with WSL 2 Integration (Recommended for Windows)

1. **Install Docker Desktop for Windows** (if not already installed):
   - Download from: https://www.docker.com/products/docker-desktop/
   - Install and start Docker Desktop

2. **Enable WSL 2 Integration**:
   - Open Docker Desktop
   - Go to Settings → Resources → WSL Integration
   - Enable integration for your Ubuntu distribution (e.g., "Ubuntu" or "Ubuntu-22.04")
   - Click "Apply & Restart"

3. **Restart WSL**:
   ```bash
   # In PowerShell (Windows), run:
   wsl --shutdown
   
   # Then restart your WSL terminal
   ```

4. **Verify Docker is working**:
   ```bash
   docker --version
   docker ps
   ```

### Option 2: Install Docker Directly in WSL 2 (Alternative)

If you prefer not to use Docker Desktop, you can install Docker directly in WSL 2:

1. **Run the Ansible playbook** (it will install Docker):
   ```bash
   cd ansible
   ./run-playbook.sh
   ```

2. **After installation, you may need to**:
   - Log out and log back in (to refresh group membership)
   - Or run: `newgrp docker`

3. **Start Docker service manually** (if needed):
   ```bash
   sudo service docker start
   ```

4. **Verify Docker is working**:
   ```bash
   docker --version
   sudo docker ps
   ```

## After Docker is Working

Once Docker is available, you can:

1. **Check if containers are running**:
   ```bash
   docker ps
   ```

2. **If containers aren't running, start them manually**:
   ```bash
   cd /opt/nextjs-app
   docker-compose up -d
   ```

3. **Or re-run the Ansible playbook**:
   ```bash
   cd ~/path/to/ansible
   ./run-playbook.sh
   ```

## Troubleshooting

### If Docker Desktop integration doesn't work:
- Make sure WSL 2 is enabled: `wsl --list --verbose` (should show VERSION 2)
- Restart Docker Desktop
- Check Docker Desktop logs

### If Docker service won't start in WSL 2:
```bash
# Check Docker service status
sudo service docker status

# Start Docker service
sudo service docker start

# Enable Docker to start on boot
sudo systemctl enable docker
```

### Permission denied errors:
```bash
# Add your user to docker group (if not already done)
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker
```



