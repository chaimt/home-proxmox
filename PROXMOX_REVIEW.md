# Proxmox Configuration Review
_Generated: 2026-07-17_

## Cluster: TurelHome

| Node | Status | Uptime | CPU | RAM |
|------|--------|--------|-----|-----|
| home1 | online | 54d | 2.7% | 80% (24/30 GB) |
| home2 | online | 43d | 43.8% | **83%** (19/23 GB) — Intel i7-8550U |
| home3 | online | ~1h (recently rebooted) | 0.7% | 9.5% |
| home4 | online | ~1h (recently rebooted) | 0.3% | 28% (8/29 GB) — AMD Ryzen 9 7940HS |

---

## Suggestions

### 1. Disable Enterprise APT Repo (home1 & home2) — HIGH PRIORITY

**Problem:** Both `home1` and `home2` have the Proxmox enterprise repository enabled (`https://enterprise.proxmox.com/debian/pve`), but no subscription key is present on any node. This causes `apt-get update` to fail — 34 failures recorded in the task log (25 on home2, 7 on home1).

**Fix:** On each affected node in the Proxmox web UI:
1. Go to **Node → Updates → Repositories**
2. Select the **Enterprise** PVE repo and click **Disable**
3. Confirm the **No-Subscription** repo (`http://download.proxmox.com/debian/pve`) is enabled

> home3 and home4 are already correctly configured.

---

### 2. Watch home2 Memory Pressure — MEDIUM

**Problem:** home2 is running at 83% RAM (19/23 GB). It hosts `truenas` (VM 100, 15 GB allocated) and `workflows` (CT 104, 1 GB allocated), leaving little headroom for spikes.

**Options:**
- Reduce TrueNAS VM memory allocation if it doesn't need all 15 GB
- Monitor for OOM events or consider migrating `workflows` to a less-loaded node

---

### 3. Set Up Automated Backups — MEDIUM

**Problem:** No backup jobs are configured (`vzdump.cron` is empty, cluster backup job count = 0). There are no scheduled backups for any VMs or containers.

**Fix:** In the Proxmox web UI, go to **Datacenter → Backup** and add a job. Suggested starting point:
- **Schedule:** Weekly (e.g. Sunday 02:00)
- **Storage:** `truenas` (NFS — 940 GB, only 13% used)
- **VMs/CTs to include at minimum:** haos13.1 (103), truenas (100), workflows (104)
- **Mode:** Snapshot
- **Retention:** Keep last 3–4

---

### 4. Configure MCP SSH or Remove Placeholder Values — LOW

**Problem:** The ProxmoxMCP-Plus config at `~/workspace/mcp/ProxmoxMCP-Plus/proxmox-config/config.json` still contains placeholder values:
- `ssh.host_overrides.pve` = `"your-proxmox-node-ip-or-ssh-alias"`
- `api_tunnel.ssh_host` = `"your-ssh-alias"`
- `ssh.key_file` = `~/.ssh/proxmox_key` — **this key file does not exist**

SSH-based features (node shell commands) will not work. The REST API connection is unaffected and working fine.

**Option A — Set up SSH access:**
1. Generate a key: `ssh-keygen -t ed25519 -f ~/.ssh/proxmox_key`
2. Create `mcp-agent` user on Proxmox nodes and add the public key
3. Update `host_overrides.pve` to `10.0.0.91` (or an SSH alias)

**Option B — Leave SSH disabled (if API-only access is sufficient):**
No action needed — the MCP server works via the API without SSH.

---

### 5. Reduce API Token Privileges — LOW

**Problem:** The `mcp` API token is scoped to `root@pam` with `privsep: 0` (no privilege separation), giving it full root-level API access. This is a broader attack surface than necessary.

**Suggestion:**
1. Create a dedicated PVE user (e.g. `mcp@pve`)
2. Grant only the roles needed: `PVEAuditor` for read-only, or `PVEAdmin` if write access is required
3. Create a token under that user and update `config.json`

---

### 6. Investigate MCP JSONRPCMessage Errors — LOW

**Problem:** `proxmox_mcp.log` contains:
```
ERROR - Received exception from stream: 11 validation errors for JSONRPCMessage
```

This may indicate a version mismatch between the MCP server library and the client. API operations still work.

**Suggestion:** Check for updates to ProxmoxMCP-Plus or the `mcp` Python package. Compare the installed version against the latest release.
