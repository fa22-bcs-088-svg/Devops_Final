#!/bin/bash

# Quick start script for running Ansible playbook
# This script helps you run the Ansible playbook easily

echo "=========================================="
echo "Ansible Playbook Runner"
echo "=========================================="
echo ""

# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible is not installed!"
    echo "Please install Ansible first:"
    echo "  sudo apt update"
    echo "  sudo apt install -y ansible"
    exit 1
fi

echo "✅ Ansible is installed"
echo ""

# Check if we're in the ansible directory
if [ ! -f "playbook.yaml" ]; then
    echo "⚠️  Warning: playbook.yaml not found in current directory"
    echo "Please run this script from the ansible/ directory"
    exit 1
fi

echo "Running Ansible playbook..."
echo ""

# Check if user has passwordless sudo
if sudo -n true 2>/dev/null; then
    echo "✅ Passwordless sudo is configured"
    echo ""
    # Run without asking for password
    ansible-playbook playbook.yaml -i host.ini "$@"
else
    echo "⚠️  Sudo password required"
    echo "The playbook needs sudo privileges to install packages and Docker."
    echo "You can either:"
    echo "  1. Enter your sudo password when prompted (recommended for first run)"
    echo "  2. Set up passwordless sudo (run: ./setup-passwordless-sudo.sh)"
    echo ""
    # Run with password prompt
    ansible-playbook playbook.yaml -i host.ini --ask-become-pass "$@"
fi

# Check exit status
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Playbook executed successfully!"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "  1. Check containers: docker ps"
    echo "  2. View logs: docker logs nextjs-web"
    echo "  3. Test app: curl http://localhost:3000"
else
    echo ""
    echo "=========================================="
    echo "❌ Playbook execution failed!"
    echo "=========================================="
    echo ""
    echo "Troubleshooting:"
    echo "  1. Check the error messages above"
    echo "  2. Run with verbose output: ./run-playbook.sh -v"
    echo "  3. Check Ansible documentation: ansible-playbook --help"
    exit 1
fi

