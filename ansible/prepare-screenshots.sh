#!/bin/bash

# Script to prepare all files for screenshot capture

echo "=========================================="
echo "Preparing Files for Screenshots"
echo "=========================================="
echo ""

cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible

echo "📸 SCREENSHOT 1: Playbook File (playbook.yaml)"
echo "=========================================="
echo ""
head -50 playbook.yaml
echo ""
echo "--- (showing first 50 lines, file has more) ---"
echo ""
read -p "Press Enter to continue to next screenshot..."
echo ""

echo "📸 SCREENSHOT 2: Inventory File (host.ini)"
echo "=========================================="
echo ""
cat host.ini
echo ""
read -p "Press Enter to continue to next screenshot..."
echo ""

echo "📸 SCREENSHOT 3: File Structure"
echo "=========================================="
echo ""
ls -la
echo ""
read -p "Press Enter to continue to verification..."
echo ""

echo "📸 BONUS SCREENSHOT 4: Container Status"
echo "=========================================="
echo ""
docker ps | grep nextjs
echo ""
read -p "Press Enter to continue..."
echo ""

echo "📸 BONUS SCREENSHOT 5: Application Test"
echo "=========================================="
echo ""
curl -I http://localhost:3000 2>/dev/null | head -10
echo ""
echo "=========================================="
echo "✅ All screenshots prepared!"
echo "=========================================="










