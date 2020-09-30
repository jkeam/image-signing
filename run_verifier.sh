#!/bin/bash

ME=192.168.1.11
docker run --privileged \
  -e IMAGE=quay.io/jkeam/hello-python:latest \
  -e IDENTITY=openshift@example.com \
  -e SIGSERVER_ADMIN_URL="http://$ME:8040/access/api/v1/users/access-admin" \
  -e SIGSERVER_URL="http://$ME:8081/artifactory/generic-local" \
  -e SIGSERVER_USERNAME=admin \
  -e SIGSERVER_PASSWORD=rootpassword \
  -it quay.io/jkeam/image-signer:latest \
  /bin/bash
