# Docker Image Version Check Report

Generated: $(date)

## Summary

This report shows which Docker images have newer versions available.

## Updates Available

### High Priority Updates

1. **portainer/portainer-ce:2.33.2** → **2.37.0-alpine**
   - Location: `base_image/docker-compose.yaml`
   - Major version update available

2. **authelia/authelia:4.38.8** → **4.39.15**
   - Location: `swag/docker-compose.yaml`
   - Security and feature updates

3. **n8nio/n8n:2.1.4** → **2.2.1**
   - Location: `workflows/docker-compose.yaml`
   - Minor version update

4. **nicolargo/glances:4.3.1** → **4.4.1**
   - Location: Multiple files (elasticsearch, monitor, swag, tools)
   - Minor version update

### Minor Updates

5. **duplicati/duplicati:2.2.0.100** → **2.2.0.102**
   - Location: Multiple files
   - Patch version update

6. **crazymax/diun:4.30** → **4.30.0**
   - Location: Multiple files
   - Patch version update

7. **headscale/headscale:0.24.0-beta.2** → **v0.27.1**
   - Location: `headscale/docker-compose.yaml`
   - Beta to stable update available

8. **b3log/siyuan:v3.5.0** → **v3.5.1**
   - Location: `pkm/docker-compose.yaml`
   - Patch version update

9. **lscr.io/linuxserver/resilio-sync:3.1.0** → **3.1.2**
   - Location: `pkm/docker-compose.yaml`
   - Patch version update

### Base Image Updates

10. **redis:alpine** → **8.4-alpine3.22**
    - Location: Multiple files (swag, wallabag, workflows)
    - Base image update

11. **mariadb:latest** → **12.1-ubi10**
    - Location: `wallabag/docker-compose.yaml`
    - Major version update (check compatibility)

12. **ollama/ollama:latest** → **0.13.5-rocm**
    - Location: `olama/docker-compose.yaml`
    - Version update (note: `-rocm` tag may be platform-specific)

## Up to Date

- amir20/dozzle:v8.14.12
- louislam/uptime-kuma:2.0.2
- linuxserver/heimdall:2.7.6
- lscr.io/linuxserver/pairdrop:1.11.2
- wallabag/wallabag:2.6.14

## Manual Check Needed

These images are hosted on GitHub Container Registry (GHCR) and require manual checking:

1. **ghcr.io/ajnart/homarr:0.15.10**
   - Location: `monitor/docker-compose.yaml`
   - Check: https://github.com/ajnart/homarr/pkgs/container/homarr

2. **ghcr.io/mealie-recipes/mealie:v3.3.2**
   - Location: `recipe management/docker-compose.yaml`
   - Check: https://github.com/mealie-recipes/mealie/pkgs/container/mealie

3. **ghcr.io/linuxserver/swag:2.10.0**
   - Location: `swag/docker-compose.yaml`
   - Check: https://github.com/linuxserver/swag/pkgs/container/swag

4. **ghcr.io/open-webui/open-webui:main**
   - Location: `olama/docker-compose.yaml`
   - Check: https://github.com/open-webui/open-webui/pkgs/container/open-webui

5. **ghcr.io/gurucomputing/headscale-ui:latest**
   - Location: `headscale/docker-compose.yaml`
   - Check: https://github.com/gurucomputing/headscale-ui/pkgs/container/headscale-ui

6. **chaimt/model-server:main**
   - Location: `model-serving/docker-compose.yaml`
   - Custom image - check your registry

7. **docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest**
   - Location: `tools/docker-compose.yaml`
   - Custom registry - check manually

8. **evanbuss/openbooks** (no tag specified)
   - Location: `tools/docker-compose.yaml`
   - Check Docker Hub manually

## Environment Variable Images

These images use environment variables and need to be checked in your `.env` files:

- **docker.elastic.co/elasticsearch/elasticsearch:${STACK_VERSION}**
  - Location: `elasticsearch/docker-compose.yml`
  - Check your `.env` file for `STACK_VERSION`

- **docker.elastic.co/kibana/kibana:${STACK_VERSION}**
  - Location: `elasticsearch/docker-compose.yml`
  - Check your `.env` file for `STACK_VERSION`

- **Zabbix images** (multiple)
  - Location: `zabbix/docker-compose.yaml`
  - Check your `.env` file for:
    - `ZABBIX_POSTGRES_IMAGE_TAG`
    - `ZABBIX_SERVER_IMAGE_TAG`
    - `ZABBIX_WEB_IMAGE_TAG`
    - `ZABBIX_AGENT_IMAGE_TAG`

## Recommendations

1. **Priority Updates**: Update portainer, authelia, and n8n first as they have significant version jumps
2. **Test Updates**: Always test updates in a staging environment before applying to production
3. **Backup**: Create backups before updating critical services
4. **Check Changelogs**: Review changelogs for breaking changes before updating
5. **GHCR Images**: Manually check GitHub Container Registry images using the links provided above

## How to Update

To update an image, edit the corresponding `docker-compose.yaml` file and change the image tag, then run:

```bash
docker-compose pull
docker-compose up -d
```

Or use the update scripts if available (e.g., `update.sh` files in some directories).

