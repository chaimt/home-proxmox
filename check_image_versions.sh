#!/bin/bash

# Script to check Docker images for newer versions
# Uses Docker Hub API and GitHub Container Registry API

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check Docker Hub image tags
check_dockerhub_image() {
    local image=$1
    local current_tag=$2
    local namespace=$(echo $image | cut -d'/' -f1)
    local repo=$(echo $image | cut -d'/' -f2)
    
    # Handle images without namespace (library images)
    if [[ "$namespace" == "$repo" ]]; then
        namespace="library"
    fi
    
    echo -n "Checking ${BLUE}$image:$current_tag${NC}... "
    
    # Get tags from Docker Hub API
    local response=$(curl -s "https://hub.docker.com/v2/repositories/${namespace}/${repo}/tags?page_size=100" 2>/dev/null)
    
    if [ $? -ne 0 ] || [ -z "$response" ]; then
        echo -e "${YELLOW}API error${NC}"
        return
    fi
    
    # Extract latest version tag (excluding latest, main, etc.)
    local latest_tag=$(echo "$response" | grep -o '"name":"[^"]*"' | grep -v '"name":"latest"' | grep -v '"name":"main"' | head -1 | cut -d'"' -f4)
    
    if [ -z "$latest_tag" ]; then
        echo -e "${YELLOW}No tags found${NC}"
        return
    fi
    
    if [ "$latest_tag" != "$current_tag" ]; then
        echo -e "${GREEN}Update available: $latest_tag${NC}"
    else
        echo -e "${GREEN}Up to date${NC}"
    fi
}

# Function to check GitHub Container Registry image tags
check_ghcr_image() {
    local image=$1
    local current_tag=$2
    local repo=$(echo $image | sed 's|ghcr.io/||')
    
    echo -n "Checking ${BLUE}$image:$current_tag${NC}... "
    
    # Get tags from GitHub API (requires authentication for private repos, but public repos work)
    local response=$(curl -s "https://api.github.com/orgs/$(echo $repo | cut -d'/' -f1)/packages/container/$(echo $repo | cut -d'/' -f2)/versions" 2>/dev/null)
    
    if [ $? -ne 0 ] || [ -z "$response" ] || echo "$response" | grep -q "Not Found"; then
        # Try alternative API endpoint
        response=$(curl -s "https://github.com/$(echo $repo | cut -d'/' -f1-2)/pkgs/container/$(echo $repo | cut -d'/' -f2)" 2>/dev/null)
        echo -e "${YELLOW}Check manually${NC}"
        return
    fi
    
    echo -e "${YELLOW}Check manually (GHCR API limited)${NC}"
}

# Function to check LinuxServer.io images
check_lscr_image() {
    local image=$1
    local current_tag=$2
    local repo=$(echo $image | sed 's|lscr.io/linuxserver/||')
    
    echo -n "Checking ${BLUE}$image:$current_tag${NC}... "
    
    # LinuxServer.io images are on Docker Hub
    check_dockerhub_image "linuxserver/$repo" "$current_tag"
}

# Main checking logic
echo "=========================================="
echo "Docker Image Version Checker"
echo "=========================================="
echo ""

# Extract images from docker-compose files
images=(
    "portainer/portainer-ce:2.37.0-alpine"
    "nicolargo/glances:4.3.1"
    "duplicati/duplicati:2.2.0.100"
    "crazymax/diun:4.30"
    "amir20/dozzle:v8.14.12"
    "headscale/headscale:0.24.0-beta.2"
    "ghcr.io/gurucomputing/headscale-ui:latest"
    "louislam/uptime-kuma:2.0.2"
    "linuxserver/heimdall:2.7.6"
    "ghcr.io/ajnart/homarr:0.15.10"
    "lscr.io/linuxserver/pairdrop:1.11.2"
    "b3log/siyuan:v3.5.0"
    "lscr.io/linuxserver/resilio-sync:3.1.0"
    "ghcr.io/mealie-recipes/mealie:v3.3.2"
    "ghcr.io/linuxserver/swag:2.10.0"
    "authelia/authelia:4.38.8"
    "redis:alpine"
    "evanbuss/openbooks:latest"
    "docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest"
    "wallabag/wallabag:2.6.14"
    "mariadb:latest"
    "n8nio/n8n:2.1.4"
    "ghcr.io/open-webui/open-webui:main"
    "ollama/ollama:latest"
)

for image_tag in "${images[@]}"; do
    image=$(echo $image_tag | cut -d':' -f1)
    tag=$(echo $image_tag | cut -d':' -f2)
    
    if [[ "$image" == *"ghcr.io"* ]]; then
        check_ghcr_image "$image" "$tag"
    elif [[ "$image" == *"lscr.io"* ]]; then
        check_lscr_image "$image" "$tag"
    else
        check_dockerhub_image "$image" "$tag"
    fi
    
    sleep 0.5  # Rate limiting
done

echo ""
echo "=========================================="
echo "Note: Some images may need manual checking"
echo "=========================================="

