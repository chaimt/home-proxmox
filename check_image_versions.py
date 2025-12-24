#!/usr/bin/env python3
"""
Check Docker images for newer versions
"""
import json
import re
import sys
from urllib.request import urlopen, Request
from urllib.error import HTTPError, URLError
from typing import Optional, Tuple, List

# Colors for terminal output
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    CYAN = '\033[0;36m'
    NC = '\033[0m'  # No Color

def get_dockerhub_tags(namespace: str, repo: str) -> List[str]:
    """Get tags from Docker Hub API"""
    try:
        url = f"https://hub.docker.com/v2/repositories/{namespace}/{repo}/tags?page_size=100"
        req = Request(url)
        req.add_header('User-Agent', 'Docker-Image-Checker/1.0')
        
        with urlopen(req, timeout=10) as response:
            data = json.loads(response.read())
            tags = [tag['name'] for tag in data.get('results', [])]
            return tags
    except (HTTPError, URLError, json.JSONDecodeError) as e:
        return []

def get_latest_version_tag(tags: List[str], current_tag: str) -> Optional[str]:
    """Extract latest version tag, preferring semantic versions"""
    if not tags:
        return None
    
    # Filter out non-version tags and platform-specific tags
    version_tags = []
    skip_patterns = [
        r'latest', r'main', r'master', r'dev', r'nightly',
        r'arm64', r'amd64', r'armv7', r'windows', r'linux',
        r'beta', r'alpha', r'rc', r'canary', r'debug',
        r'ls\d+', r'-ls\d+',  # LinuxServer.io build numbers
    ]
    
    for tag in tags:
        # Skip if matches any skip pattern
        skip = False
        for pattern in skip_patterns:
            if re.search(pattern, tag.lower()):
                skip = True
                break
        if skip:
            continue
        
        # Look for version-like tags (v1.2.3, 1.2.3, etc.)
        if re.match(r'^v?\d+\.\d+', tag):
            version_tags.append(tag)
    
    if not version_tags:
        # Fall back to tags that look like versions but might have suffixes
        for tag in tags:
            if tag.lower() in ['latest', 'main', 'master']:
                continue
            # Check if it starts with a version number
            if re.match(r'^v?\d+', tag):
                # Only include if it doesn't have platform suffixes
                if not re.search(r'-(arm|amd|windows|linux|beta|alpha|rc)', tag.lower()):
                    version_tags.append(tag)
    
    if not version_tags:
        return None
    
    # Sort by version (simple numeric sort)
    try:
        # Extract numeric parts for sorting
        def version_key(tag):
            # Remove 'v' prefix and extract numbers
            nums = re.findall(r'\d+', tag)
            return [int(n) for n in nums] if nums else [0]
        
        version_tags.sort(key=version_key, reverse=True)
    except:
        version_tags.sort(reverse=True)
    
    return version_tags[0] if version_tags else None

def get_ghcr_tags(owner: str, repo: str) -> List[str]:
    """Get tags from GitHub Container Registry"""
    try:
        # Try GitHub API for package versions
        url = f"https://api.github.com/orgs/{owner}/packages/container/{repo}/versions"
        req = Request(url)
        req.add_header('Accept', 'application/vnd.github.v3+json')
        req.add_header('User-Agent', 'Docker-Image-Checker/1.0')
        
        with urlopen(req, timeout=10) as response:
            data = json.loads(response.read())
            tags = []
            for version in data:
                for tag in version.get('metadata', {}).get('container', {}).get('tags', []):
                    if tag not in tags:
                        tags.append(tag)
            return tags
    except HTTPError as e:
        if e.code == 404:
            # Try as user instead of org
            try:
                url = f"https://api.github.com/users/{owner}/packages/container/{repo}/versions"
                req = Request(url)
                req.add_header('Accept', 'application/vnd.github.v3+json')
                req.add_header('User-Agent', 'Docker-Image-Checker/1.0')
                
                with urlopen(req, timeout=10) as response:
                    data = json.loads(response.read())
                    tags = []
                    for version in data:
                        for tag in version.get('metadata', {}).get('container', {}).get('tags', []):
                            if tag not in tags:
                                tags.append(tag)
                    return tags
            except:
                return []
        return []
    except (URLError, json.JSONDecodeError):
        return []

def check_image(image_name: str, current_tag: str) -> Tuple[bool, Optional[str]]:
    """Check if image has newer version available"""
    # Handle GHCR images
    if image_name.startswith("ghcr.io/"):
        repo_path = image_name.replace("ghcr.io/", "")
        parts = repo_path.split('/')
        if len(parts) >= 2:
            owner = parts[0]
            repo = parts[1]
            tags = get_ghcr_tags(owner, repo)
            if tags:
                latest_tag = get_latest_version_tag(tags, current_tag)
                if latest_tag:
                    is_update_available = latest_tag != current_tag
                    return is_update_available, latest_tag
        return False, None
    
    # Parse image name for Docker Hub
    parts = image_name.split('/')
    
    if len(parts) == 1:
        # Library image (e.g., redis)
        namespace = "library"
        repo = parts[0]
    elif len(parts) == 2:
        namespace = parts[0]
        repo = parts[1]
    else:
        # Multi-level namespace (e.g., docker.elastic.co/elasticsearch/elasticsearch)
        # For now, skip these or handle specially
        return False, None
    
    tags = get_dockerhub_tags(namespace, repo)
    if not tags:
        return False, None
    
    latest_tag = get_latest_version_tag(tags, current_tag)
    if not latest_tag:
        return False, None
    
    is_update_available = latest_tag != current_tag
    return is_update_available, latest_tag

def main():
    # Extract images from docker-compose files
    images = [
        ("portainer/portainer-ce", "2.33.2"),
        ("nicolargo/glances", "4.3.1"),
        ("duplicati/duplicati", "2.2.0.100"),
        ("crazymax/diun", "4.30"),
        ("amir20/dozzle", "v8.14.12"),
        ("headscale/headscale", "0.24.0-beta.2"),
        ("louislam/uptime-kuma", "2.0.2"),
        ("linuxserver/heimdall", "2.7.6"),
        ("ghcr.io/ajnart/homarr", "0.15.10"),
        ("lscr.io/linuxserver/pairdrop", "1.11.2"),
        ("b3log/siyuan", "v3.5.0"),
        ("lscr.io/linuxserver/resilio-sync", "3.1.0"),
        ("ghcr.io/mealie-recipes/mealie", "v3.3.2"),
        ("ghcr.io/linuxserver/swag", "2.10.0"),
        ("authelia/authelia", "4.38.8"),
        ("redis", "alpine"),
        ("wallabag/wallabag", "2.6.14"),
        ("mariadb", "latest"),
        ("n8nio/n8n", "2.1.4"),
        ("ollama/ollama", "latest"),
    ]
    
    print("=" * 60)
    print("Docker Image Version Checker")
    print("=" * 60)
    print()
    
    updates_available = []
    check_failed = []
    
    for image, current_tag in images:
        full_image = f"{image}:{current_tag}"
        print(f"Checking {Colors.BLUE}{full_image}{Colors.NC}... ", end="", flush=True)
        
        # Handle special registries (GHCR is now handled in check_image)
        
        if image.startswith("lscr.io/"):
            # LinuxServer.io images are on Docker Hub with linuxserver/ prefix
            repo = image.replace("lscr.io/linuxserver/", "")
            image = f"linuxserver/{repo}"
        
        if image.startswith("docker.stirlingpdf.com/"):
            print(f"{Colors.YELLOW}Manual check needed (Custom registry){Colors.NC}")
            check_failed.append(full_image)
            continue
        
        try:
            has_update, latest_tag = check_image(image, current_tag)
            
            if latest_tag is None:
                print(f"{Colors.YELLOW}Could not determine latest version{Colors.NC}")
                check_failed.append(full_image)
            elif has_update:
                print(f"{Colors.GREEN}Update available: {latest_tag}{Colors.NC}")
                updates_available.append((full_image, current_tag, latest_tag))
            else:
                print(f"{Colors.GREEN}Up to date{Colors.NC}")
        except Exception as e:
            print(f"{Colors.RED}Error: {str(e)}{Colors.NC}")
            check_failed.append(full_image)
        
        # Small delay to avoid rate limiting
        import time
        time.sleep(0.3)
    
    print()
    print("=" * 60)
    print("Summary")
    print("=" * 60)
    
    if updates_available:
        print(f"\n{Colors.GREEN}Updates Available:{Colors.NC}")
        for image, current, latest in updates_available:
            print(f"  {image}")
            print(f"    Current: {current} → Latest: {latest}")
    
    if check_failed:
        print(f"\n{Colors.YELLOW}Manual Check Needed:{Colors.NC}")
        for image in check_failed:
            print(f"  {image}")
    
    if not updates_available and not check_failed:
        print(f"\n{Colors.GREEN}All checked images are up to date!{Colors.NC}")

if __name__ == "__main__":
    main()

