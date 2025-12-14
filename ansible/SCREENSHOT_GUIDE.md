# Screenshot Guide for Ansible Assignment Submission

## Required Screenshots

Based on your assignment requirements, you need to provide screenshots showing:

### 1. ✅ Ansible Playbook File (`ansible/playbook.yaml`)

**What to screenshot:**
- Show the playbook file structure
- Display key sections of the playbook (at least the header and a few tasks)

**How to capture:**
```bash
# Option 1: Show file in terminal
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible
head -50 playbook.yaml

# Option 2: Use cat with less
cat playbook.yaml | less
```

**What to show:**
- File name: `playbook.yaml`
- Playbook name and hosts
- At least 3-5 tasks showing different operations (install, configure, deploy)

---

### 2. ✅ Inventory File (`ansible/host.ini`)

**What to screenshot:**
- Show the inventory file contents
- Display the `[web]` group configuration

**How to capture:**
```bash
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible
cat host.ini
```

**What to show:**
- File name: `host.ini`
- The `[web]` group with localhost configuration
- Connection settings

---

### 3. ✅ Successful Playbook Run (MAIN REQUIREMENT)

**You already have this!** The screenshot should show:

**What must be visible:**
- ✅ Playbook execution start
- ✅ All tasks showing `ok:` or `changed:` status
- ✅ **PLAY RECAP** showing:
  - `ok=X` (tasks completed successfully)
  - `failed=0` (no failures)
  - `changed=X` (resources modified)
- ✅ Final success message: "✅ Playbook executed successfully!"
- ✅ Deployment status showing:
  - Next.js application running
  - PostgreSQL database running
  - Container status

**Your current screenshot shows:**
- ✅ All tasks completed (`ok=23 changed=11 failed=0`)
- ✅ Deployment completed message
- ✅ Container status displayed
- ✅ Next steps provided

---

## Additional Recommended Screenshots (Bonus Points)

### 4. Verification Screenshots

**A. Container Status:**
```bash
docker ps | grep nextjs
```
Shows containers are running

**B. Application Accessibility:**
```bash
curl http://localhost:3000
```
Shows the app is responding

**C. Playbook File Structure:**
```bash
ls -la ansible/
```
Shows all Ansible files

---

## Screenshot Checklist

Before submitting, ensure you have:

- [ ] **Screenshot 1:** `playbook.yaml` file contents (at least header + key tasks)
- [ ] **Screenshot 2:** `host.ini` file contents (inventory configuration)
- [ ] **Screenshot 3:** Successful playbook execution (PLAY RECAP with `failed=0`)
- [ ] [Optional] Container verification (`docker ps`)
- [ ] [Optional] Application test (`curl http://localhost:3000`)

---

## How to Take Good Screenshots

1. **Use full terminal window** - Show complete output
2. **Highlight key information:**
   - Playbook name
   - Task completion status
   - PLAY RECAP summary
   - Success messages
3. **Include file paths** - Show you're in the correct directory
4. **Show timestamps** - If possible, include command prompt with path

---

## Quick Commands for Screenshots

```bash
# 1. Show playbook structure
cd /mnt/d/Desktop/semester7/devops/lab/Final_Lab_Exam/next-self-host/ansible
head -30 playbook.yaml

# 2. Show inventory file
cat host.ini

# 3. Show file listing
ls -la ansible/

# 4. Verify containers (for bonus screenshot)
docker ps | grep nextjs

# 5. Test application (for bonus screenshot)
curl -I http://localhost:3000
```

---

## What Your Screenshots Should Demonstrate

1. **Playbook File:** Shows automation tasks (install, configure, deploy)
2. **Inventory File:** Shows target hosts configuration
3. **Successful Run:** Proves the playbook:
   - ✅ Installed dependencies (Docker, packages)
   - ✅ Deployed app configs/secrets (.env file)
   - ✅ Automated Docker deployment (containers running)
   - ✅ Completed without errors

---

## Your Current Status

✅ **You already have Screenshot 3** (successful playbook run) - This is the main requirement!

You just need to add:
- Screenshot 1: `playbook.yaml` file
- Screenshot 2: `host.ini` file

Optional but recommended:
- Screenshot 4: Container verification
- Screenshot 5: Application test



