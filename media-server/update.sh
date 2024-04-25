#!/bin/sh
docker-compose pull
docker-compose stop
docker image prune -af
docker-compose start -d
docker-compose logs -f