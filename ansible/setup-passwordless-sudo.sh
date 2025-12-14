#!/bin/bash

# Script to set up passwordless sudo for Ansible
# This allows Ansible to run without prompting for password

echo "=========================================="
echo "Setting up Passwordless Sudo for Ansible"
echo "=========================================="
echo ""

# Get current username
CURRENT_USER=$(whoami)

echo "Current user: $CURRENT_USER"
echo ""
echo "This will allow $CURRENT_USER to run sudo commands without a password."
echo "This is safe for local development but use with caution in production."
echo ""

read -p "Do you want to continue? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
fi

# Check if the sudoers entry already exists
if sudo grep -q "^$CURRENT_USER ALL=(ALL) NOPASSWD: ALL" /etc/sudoers 2>/dev/null; then
    echo "✅ Passwordless sudo is already configured for $CURRENT_USER"
    exit 0
fi

# Create sudoers entry
echo "Configuring passwordless sudo..."
echo "$CURRENT_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$CURRENT_USER-nopasswd > /dev/null

# Verify it was added
if sudo grep -q "^$CURRENT_USER ALL=(ALL) NOPASSWD: ALL" /etc/sudoers.d/$CURRENT_USER-nopasswd 2>/dev/null; then
    echo "✅ Passwordless sudo configured successfully!"
    echo ""
    echo "You can now run the Ansible playbook without entering your password."
    echo "Test it with: sudo -n true"
else
    echo "❌ Failed to configure passwordless sudo"
    exit 1
fi








