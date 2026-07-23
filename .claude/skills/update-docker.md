---
name: update-docker
description: Update all Docker image versions across compose files, commit, and redeploy via Portainer
---

# Skill: update-docker

Update all Docker image versions across the project, commit, and redeploy via Portainer.

## When to use

When the user asks to "update docker", "upgrade images", "update to latest", or "redeploy stacks".

## Steps

### 1. Discover compose files

Find all `docker-compose.yaml` / `docker-compose.yml` files, **excluding** the `archive/` directory:

```bash
find . -name "docker-compose.y*ml" -not -path "*/archive/*"
```

### 2. Extract images with pinned versions

For each compose file, extract lines like `image: repo/name:VERSION`. Skip images that:
- Already use `latest` tag
- Use a local build reference (e.g. `chaimt/model-server:main`)
- Are commented out

### 3. Look up the latest version for each image

Use the Docker Hub API or GitHub Releases API depending on the registry:

**Docker Hub** (`docker.io`, `hub.docker.com`, or no registry prefix):
```
https://hub.docker.com/v2/repositories/{owner}/{image}/tags?page_size=25&ordering=last_updated
```
Pick the most recent non-`latest`, non-`edge` stable tag that matches the pinning style (e.g. `2.3.0.4-stable` style → look for similar stable tags).

**GitHub Container Registry** (`ghcr.io`):
```
https://api.github.com/repos/{owner}/{repo}/releases/latest
```
Use the tag_name from the response.

**LinuxServer** (`lscr.io/linuxserver/`):
Use Docker Hub API under `lscr.io` organization — most map to `lscr.io/linuxserver/{image}`.

**Special cases:**
- `docker.stirlingpdf.com` — check https://github.com/Stirling-Tools/Stirling-PDF/releases/latest
- `alpine/openclaw` — check the image's release page or Docker Hub
- `rcourtman/pulse` — check https://github.com/rcourtman/Pulse/releases/latest

Call WebFetch or WebSearch to retrieve release info when needed.

### 4. Update compose files

For each image where a newer version is available, do an in-place edit of the compose file:
- Replace the old tag with the new tag
- Preserve the exact surrounding YAML (indentation, env var wrappers like `${VAR:-image:tag}`)

Keep track of all changes made:
```
tools/docker-compose.yaml:
  duplicati/duplicati: 2.3.0.4-stable → 2.4.0.0-stable
  crazymax/diun: 4.33.0 → 4.34.0
monitor/docker-compose.yaml:
  ...
```

If no changes were found, report that all images are already at the latest version and stop.

### 5. Commit

Stage only the modified compose files:
```bash
git add <modified files>
git commit -m "chore: update docker image versions

<list of all image updates>"
```

The commit body should list each updated image in the format:
```
- service-name (file): oldtag → newtag
```

### 6. Redeploy via Portainer

Use the Portainer MCP tools to redeploy each affected stack.

**Stack → Environment mapping** (from Portainer):

| Stack name | Stack ID | Env ID |
|-----------|----------|--------|
| monitor   | 7        | 2      |
| worflows  | 8        | 4      |
| tools     | 37       | 9      |
| olama     | 63       | 15     |
| siyuan    | 39       | 11     |

For each stack whose compose file was modified:

1. List containers in the environment:
   ```
   list_containers(environmentId=<env_id>)
   ```

2. Restart each running container in that stack:
   ```
   restart_container(environmentId=<env_id>, containerId=<id>)
   ```

Skip stacks with `Status: inactive` or environments with `Status: down`.

### 7. Report

After all restarts complete, summarize:
- Which compose files were updated and what changed
- Which stacks were redeployed
- Any errors or skipped items
