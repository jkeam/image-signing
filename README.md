# Image Signing

This repo demonstrates how we can perform image signing and use something like Artifactory to store those signatures.  All instructions below have only been tested on my Mac running OSX 10.15.6.

## Running

### Sigserver

1.  `run_sigserver.sh` - this will take a few minutes
2.  After it's up, go to http://localhost:8081 and you will be directed to the main login page.  Login with username `admin` and password `password`
3.  When prompted, reset admin password to `rootpassword` and click Next
4.  Skip Set Base URL
5.  Skip Configure Default Proxy
6.  Create `Generic` Repository and click Next
7.  Verify it's named `generic-local` and click Finish

### Signer

1.  Open `run_signer.sh` and replace `ME` with your IP address.
2.  `./run_signer.sh`

### Validate
You can either navigate in through the Artifactory UI or curl.

```
curl --user admin:rootpassword http://localhost:8082/artifactory/generic-local/jkeam/hello-node@sha256=2cbdb73c9177e63e85d267f738e99e368db3f806eab4c541f5c6b719e69f1a2b/signature-1` --output signature
cat ./signature
```

### Validate Signature

```
./run_verifier.sh

# replace default.yaml with your IP address
# copy the contents of default.yaml to /etc/containers/registries.d/default.yaml in the container
# copy the contents of policy.json to /etc/containers/policy.json in the container

# verify the pull fails
podman pull quay.io/jkeam/hello-node:latest

# let's add our key
mkdir /usr/share/keys
gpg --armor --output /usr/share/keys/public-key.gpg --export openshift@example.com
```


## Note

1.  Now the machine config's sigserver url should be `https://HOSTNAME:8082/artifactory/generic-local`
2.  There are keys in this repo, but they are junk keys I pulled from https://github.com/redhat-cop/image-scanning-signing-service/blob/master/deploy/secret.yaml.
