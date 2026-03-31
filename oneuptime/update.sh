services:
  duplicati:
    image: duplicati/duplicati:2.2.0.104
    container_name: ${DOCKER_CONTAINER_NAME_PREFIX}_duplicati
    hostname: duplicati
    restart: unless-stopped
    # Recommendation: Duplicati needs root user to get access to all files
    user: "${DOCKER_ROOTPUID:-0}:${DOCKER_ROOTPGID:-0}"
    network_mode: bridge
    ports:
      - 8200:8200
    volumes:
      - ${DOCKER_PATH_PERSISTENT}/duplicati_data:/data:rw
      - ${DOCKER_PATH_PERSISTENT}/duplicati_config/:/config:ro            
      - ${DOCKER_PATH_PERSISTENT}:/source:ro      
    environment:
      - TZ=${DOCKER_TZ}



  dozzle:
    container_name: ${DOCKER_CONTAINER_NAME_PREFIX}_dozzle
    image: amir20/dozzle:v10.0.1
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 9999:8080



  glances:
    container_name: ${DOCKER_CONTAINER_NAME_PREFIX}_glances
    image: nicolargo/glances:4.4.1
    restart: unless-stopped
    pid: host
    ports:
      - 61208:61208
    command: ["glances", "-w"]
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /var/docker/glances:/glances/conf


