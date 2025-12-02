#!/bin/bash

APP_NAME="legacy-sim-api"

echo "Building image using Podman..."
podman build -t $APP_NAME .

echo "Done! Image name: $APP_NAME"
