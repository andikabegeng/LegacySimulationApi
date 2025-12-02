#!/bin/bash

APP_NAME="legacy-sim-api"
CONTAINER_NAME="legacyapi"
PORT=8080

echo "Stopping old container (if exists)..."
podman stop $CONTAINER_NAME 2>/dev/null

echo "Removing old container..."
podman rm $CONTAINER_NAME 2>/dev/null

echo "Running new container..."
podman run -d \
    -p $PORT:80 \
    --name $CONTAINER_NAME \
    --net slirp4netns:port_handler=slirp4netns \
    $APP_NAME

echo "Container running!"
echo "Access API at: http://localhost:$PORT"