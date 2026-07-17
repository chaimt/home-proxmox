# VM/CT Health Report
_Generated: 2026-07-17_

## Cluster Overview

| Node | VMs/CTs hosted |
|------|---------------|
| home1 (10.0.0.91) | 102 monitor-server, 103 haos13.1 |
| home2 (10.0.0.92) | 100 truenas, 104 workflows |
| home3 (10.0.0.93) | 105 base-image |
| home4 (10.0.0.94) | 101 shut, 106 siyuan, 107 olama, 108 openclaw, 109 tools |

## Resource Snapshot

| ID | Name | Type | Node | Status | CPU | Mem % | Disk % |
|----|------|------|------|--------|-----|-------|--------|
| 100 | truenas | qemu | home2 | running | 14.2% | **93%** | — |
| 101 | shut | qemu | home4 | running | 1.5% | 23% | — |
| 102 | monitor-server | lxc | home1 | running | 0.8% | 29% | 45% |
| 103 | haos13.1 | qemu | home1 | running | 3.0% | **95%** | — |
| 104 | workflows | lxc | home2 | running | 4.6% | 54% | ~~94%~~ → **56%** ✓ |
| 105 | base-image | lxc | home3 | stopped | — | — | — |
| 106 | siyuan | lxc | home4 | running | 0.4% | 38% | **84%** |
| 107 | olama | lxc | home4 | running | 0.0% | 7% | 80% |
| 108 | openclaw | lxc | home4 | running | 0.2% | 58% | 75% |
| 109 | tools | lxc | home4 | running | 0.1% | 70% | ~~91%~~ → **80%** ✓ |

---

## Issues

### CRITICAL

#### ~~CT 104 — workflows: disk 94% full~~ ✓ FIXED
- Vacuumed systemd journal (981 MB → 100 MB), apt clean, pruned dangling Docker layers
- Result: 11 GB → 6.2 GB used (56%), 3.8 GB free

#### ~~CT 109 — tools: disk 91% full~~ ✓ FIXED
- Removed 2 unused Docker images (dozzle:v10.6.7 + diun:4.33.0, 130 MB), vacuumed journal (412 MB → 100 MB), apt clean
- Result: 5.1 GB → 4.4 GB used (80%), 1.2 GB free
- Note: Stirling PDF image is 2.27 GB and actively running — dominant consumer

---

### HIGH

#### VM 103 — haos13.1: memory 95%
- **Detail:** 21.4 GB in use of 22 GB allocated (host: home1)
- **Risk:** Home Assistant and add-ons may OOM-crash; automations silently fail
- **Fix:** Identify high-memory add-ons in HA Supervisor, or increase allocation to 24–26 GB if home1 has headroom

#### VM 100 — truenas: memory 93%
- **Detail:** ~14 GB in use of 15 GB allocated (host: home2)
- **Risk:** TrueNAS ARC cache aggressively consumes RAM; fine by design, but leaves little OS headroom
- **Fix:** Cap ZFS ARC in TrueNAS (`vfs.zfs.arc.max`) to free 2–3 GB, or reduce VM memory allocation to see if TrueNAS adjusts

#### CT 106 — siyuan: disk 84%
- **Detail:** 3.1 GB used of 4 GB — 616 MB free
- **Fix:** Resize disk (`pct resize 106 rootfs +4G`) or clean up inside the container

---

### MEDIUM

#### VM 101 — "shut": name implies unused, but running with onboot=1
- **Detail:** Windows 11 VM (UEFI + TPM + Secure Boot), 4 GB RAM, 32 GB disk, no QEMU agent installed
- **Uptime:** ~1.4h (started at home4 reboot)
- **Fix:** Confirm whether this VM is needed. If not, disable `onboot: 1` or stop and delete it

#### CT 107 — olama: disk 80%
- **Detail:** 36 GB used of 47 GB — 8.9 GB free
- **Risk:** Model downloads can be large; could fill up without warning
- **Fix:** Monitor; set up a cron alert or prune unused models inside Ollama

#### ~~VM 100 — truenas: installer ISO still mounted~~ ✓ FIXED
- `TrueNAS-13.0-U5.3.iso` detached; boot order cleaned up (`[PENDING]` — takes effect on next TrueNAS restart)

---

### LOW

#### VM 103 — haos13.1: no firewall on net0
- **Detail:** `net0` config is missing `firewall=1`; all other VMs/CTs have it enabled
- **Fix:** Enable in web UI: VM 103 → Network → net0 → Firewall ✓, or:
  ```
  # add firewall=1 to net0 line in /etc/pve/nodes/home1/qemu-server/103.conf
  ```

#### All CTs — DHCP only, no static IP pinning
- **Detail:** All containers rely on DHCP leases for their IPs; Proxmox config shows no fixed addresses
- **Risk:** If DHCP lease shifts (router reboot, lease expiry), IP changes silently and service routing breaks
- **Fix:** Either set static IPs inside each container, or configure DHCP reservations on the router per MAC address

---

## Completed Fixes (this session)

| # | Fix | Date |
|---|-----|------|
| 1 | Disabled `pve-enterprise.sources` (DEB822) on home1 & home2 — `apt-get update` now succeeds | 2026-07-17 |
| 3 | Created weekly backup job: VMs 100, 103, 104 → `truenas` storage, Sunday 02:00, snapshot mode, keep 4 | 2026-07-17 |
| 4 | CT 104 (workflows): vacuumed journal + apt clean → disk 94% → 56%, 3.8 GB free | 2026-07-17 |
| 4 | CT 109 (tools): pruned 2 unused Docker images + journal vacuum + apt clean → disk 91% → 80%, 1.2 GB free | 2026-07-17 |
| 4 | VM 100 (truenas): detached installer ISO (`TrueNAS-13.0-U5.3.iso`), boot order fixed (pending reboot) | 2026-07-17 |
