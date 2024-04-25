#!/bin/sh
git pull
docker-compose pull
docker-compose stop
docker image prune -af
docker-compose up -d
docker-compose logs -f