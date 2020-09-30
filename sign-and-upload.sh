#!/bin/bash

# Must set these ENV vars
# IMAGE, IDENTITY, SIGSERVER_URL, SIGSERVER_USERNAME, SIGSERVER_PASSWORD

echo "Will sign $IMAGE"
podman pull $IMAGE
podman image sign --sign-by $IDENTITY --directory ./ "docker://$IMAGE"
FILENAME=`find . -name "signature-*" | sort -nr | head -n 1`
curl -sSfv -X PUT \
      --user "$SIGSERVER_USERNAME:$SIGSERVER_PASSWORD" \
      --data-binary "@./$FILENAME" \
      "$SIGSERVER_URL/$FILENAME"
echo "Done"
