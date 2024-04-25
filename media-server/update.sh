#!/bin/sh
git pull
docker compose pull
docker compose stop
docker image prune -f
docker compose up -d
docker compose logs -f