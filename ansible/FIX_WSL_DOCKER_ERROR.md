# Fixing "WSL is unresponsive" Error in Docker Desktop

## The Error
```
Docker Desktop - WSL is unresponsive
Docker Desktop is unable to communicate with the Windows Subsystem for Linux.
DockerDesktop/Wsl/CommandTimedOut: c:\windows\system32\wsl.exe -l -v --all: exit status 1
```

## Solution Steps

### Step 1: Restart WSL from Windows PowerShell (Run as Administrator)

1. **Open Windows PowerShell as Administrator**:
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. **Shutdown WSL completely**:
   ```powershell
   wsl --shutdown
   ```

3. **Wait 10-15 seconds**, then verify WSL is stopped:
   ```powershell
   wsl --list --verbose
   ```

### Step 2: Restart Docker Desktop

1. **Quit Docker Desktop completely**:
   - Right-click Docker Desktop icon in system tray
   - Click "Quit Docker Desktop"
   - Wait for it to fully close

2. **Restart Docker Desktop**:
   - Open Docker Desktop from Start menu
   - Wait for it to fully start (whale icon should be steady, not animating)

### Step 3: Enable WSL Integration Again

1. **Open Docker Desktop Settings**:
   - Click the gear icon (Settings)
   - Go to Resources → WSL Integration

2. **Enable Integration**:
   - Check "Enable integration with my default WSL distro"
   - Toggle ON your Ubuntu distribution (e.g., "Ubuntu-20.04")
   - Click "Apply & Restart"

### Step 4: Verify in WSL Terminal

1. **Open your WSL/Ubuntu terminal**

2. **Test Docker**:
   ```bash
   docker --version
   docker ps
   ```

## Alternative Solutions

### If Step 1-3 doesn't work:

#### Option A: Restart Your Computer
Sometimes a full restart resolves WSL communication issues.

#### Option B: Update WSL
In PowerShell (Admin):
```powershell
wsl --update
wsl --shutdown
```

#### Option C: Check WSL Status
In PowerShell (Admin):
```powershell
# Check WSL version
wsl --list --verbose

# Should show your distro with VERSION 2
# If it shows VERSION 1, you need to convert it:
wsl --set-version Ubuntu-20.04 2
```

#### Option D: Re-register WSL Distribution
If WSL is corrupted:
```powershell
# Export your distro (backup)
wsl --export Ubuntu-20.04 C:\backup\ubuntu.tar

# Unregister
wsl --unregister Ubuntu-20.04

# Re-register
wsl --import Ubuntu-20.04 C:\WSL\Ubuntu-20.04 C:\backup\ubuntu.tar --version 2

# Set as default
wsl --set-default Ubuntu-20.04
```

## Quick Fix Script (PowerShell Admin)

Run this in PowerShell as Administrator:

```powershell
# Shutdown WSL
wsl --shutdown

# Wait a moment
Start-Sleep -Seconds 5

# Restart Docker Desktop service
Restart-Service -Name "com.docker.service" -ErrorAction SilentlyContinue

# Check WSL status
wsl --list --verbose
```

Then manually restart Docker Desktop and enable WSL integration.

## Prevention

To avoid this issue in the future:
1. Always properly shutdown WSL before closing Docker Desktop
2. Don't force-close Docker Desktop while WSL is running
3. Keep WSL and Docker Desktop updated

