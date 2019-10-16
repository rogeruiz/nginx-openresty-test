# Nginx + Open Resty configuration check

This Docker image exists to be able to run `nginx -t -c ${path_to_config_file}`
for a nginx configuration file which leverages Open Resty paths.

## Why does this exist?

This exists to minimize the amount of time it takes to build the Docker image
since Nginx and Open Resty take a while to compile. About 8 minutes. _yikes!_
