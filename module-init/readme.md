# How to use this folder

Use this folder when 3rd party modules are needed

1. Place .modl files to be imported into the gateway here
2. Add a volume to ignition service in docker compose

    ```yaml
    services:
      gateway:
        volumes:
          - ./module-init/Module-Name.modl:/usr/local/bin/ignition/user-lib/modules/Module-Name.mod
    ```
