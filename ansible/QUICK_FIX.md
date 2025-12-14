# Quick Fix for Sudo Password Error

## The Error
```
sudo: a password is required
```

## Solution Options

### Option 1: Run with Password Prompt (Quick Fix)

Just run the playbook and enter your password when prompted:

```bash
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible
./run-playbook.sh
```

When it asks for "BECOME password", enter your Ubuntu user password.

### Option 2: Set Up Passwordless Sudo (Recommended for Automation)

This allows Ansible to run without password prompts:

```bash
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible
chmod +x setup-passwordless-sudo.sh
./setup-passwordless-sudo.sh
```

Then run the playbook:
```bash
./run-playbook.sh
```

### Option 3: Manual Passwordless Sudo Setup

If the script doesn't work, do it manually:

```bash
# Add your user to sudoers with NOPASSWD
echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$(whoami)-nopasswd

# Verify it worked
sudo -n true && echo "✅ Passwordless sudo is working!"
```

## Why This Happened

The playbook needs `sudo` privileges to:
- Install system packages
- Install Docker
- Start Docker service
- Create directories in /opt

Ansible requires either:
- Your password (entered when prompted)
- Passwordless sudo (configured once)

## After Fixing

Once sudo is configured, the playbook will run successfully and deploy your Next.js application!



