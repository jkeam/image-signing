#!/bin/bash

docker run \
  -e SERVER_XML_ARTIFACTORY_MAX_THREADS=10 \
  -e SERVER_XML_ACCESS_MAX_THREADS=10 \
  -p "8000:8000" \
  -p "8040:8040" \
  -p "8080:8080" \
  -p "8081:8081" \
  -p "8082:8082" \
  -p "8070:8070" \
  -it "docker.bintray.io/jfrog/artifactory-oss:latest"
