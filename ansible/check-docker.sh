#!/bin/bash

# Script to check Docker setup and help troubleshoot

echo "=========================================="
echo "Docker Setup Checker for WSL 2"
echo "=========================================="
echo ""

# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "✅ Docker command is available"
    docker --version
else
    echo "❌ Docker command is NOT available"
    echo ""
    echo "Possible solutions:"
    echo "1. If you have Docker Desktop: Enable WSL integration in Docker Desktop settings"
    echo "2. If not: Run the Ansible playbook to install Docker: ./run-playbook.sh"
    echo ""
    exit 1
fi

echo ""

# Check if Docker daemon is running
if docker ps &> /dev/null; then
    echo "✅ Docker daemon is running"
    echo ""
    echo "Running containers:"
    docker ps
else
    echo "❌ Docker daemon is NOT running or not accessible"
    echo ""
    echo "Trying to start Docker service..."
    sudo service docker start 2>/dev/null || echo "Could not start Docker service"
    echo ""
    echo "If using Docker Desktop, make sure it's running on Windows"
    echo "If using native Docker, try: sudo service docker start"
fi

echo ""

# Check if user is in docker group
if groups | grep -q docker; then
    echo "✅ User is in docker group"
else
    echo "⚠️  User is NOT in docker group"
    echo "Adding user to docker group..."
    sudo usermod -aG docker $USER
    echo "Please log out and log back in, or run: newgrp docker"
fi

echo ""

# Check for containers
echo "Checking for Next.js containers..."
if docker ps -a | grep -q nextjs; then
    echo "✅ Found Next.js containers:"
    docker ps -a | grep nextjs
else
    echo "⚠️  No Next.js containers found"
    echo "You may need to run the Ansible playbook or start containers manually"
fi

echo ""
echo "=========================================="








