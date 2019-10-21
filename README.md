# Nginx + Open Resty configuration check

A Nginx and Open Resty ready Docker image to be leveraged by folks wanting to
use GitHub Actions.

## Why does this exist?

This exists to minimize the amount of time it takes to build the Docker image
since Nginx and Open Resty take a while to compile. About 8 minutes. _yikes!_

## How do I use this?

This Docker image can be used in GitHub Actions by having a local Dockerfile
such as the following in `.github/actions/nginx-openresty-test`

```Dockerfile
FROM rogeruiz/nginx-openresty-test:latest

# This is a local file relative to the Dockerfile named `nginx-test`.
COPY nginx-test /usr/local/bin/nginx-test

ENTRYPOINT ["nginx-test"]
```

```sh
#!/bin/sh

# Use the full path as this Docker image does not modify the $PATH variable.
/usr/local/openresty/nginx/sbin/nginx -t -c "${GITHUB_WORKSPACE}"/nginx.conf"
```

### Setting up a workflow with this

To leverage this properly, you'll also need to create a GitHub Actions Workflow
to leverage your local Actions. The `main.yml` file will live within
`.github/workflows`.

```yaml
name: Test nginx configuration file

on:
    pull_request:
        branches:
        - master

jobs:
    lint_lua:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: ./.github/actions/nginx-openresty-test
```
