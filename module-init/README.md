# `module-init` Directory

## Contents

The contents of the `module-init` directory should be module files (.modl) that are to be imported into the Ignition Gateway Docker Image. Specific modules from this directory are bind-mounted in the `docker-compose.yml`. Modules from this directory are also copied into the image during the build process in the [`Dockerfile`](../gw-build/Dockerfile), like in the case of `Tag-CICD` module for importing tags into the image.

## Usage

1. Place .modl files to be imported into the dev gateway here
2. Add volume to ignition service in docker compose, under any other volumes

    ```yaml
    services:
      ignition-gateway:
        volumes:
          - ./module-init/Module-Name.modl:/usr/local/bin/ignition/user-lib/modules/Module-Name.modl
    ```
