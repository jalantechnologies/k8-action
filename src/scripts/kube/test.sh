#!/bin/bash

# requires - DOCKER_IMAGE, DOCKER_COMMAND

if [ -f "docker-compose.test.yml" ]; then
    docker-compose -f docker-compose.test.yml up --exit-code-from app
else
    docker run -t "$DOCKER_IMAGE" "$DOCKER_COMMAND"
fi
