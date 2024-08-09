# How to use this folder

Use this folder when 3rd party modules are needed

1. Place .modl files to be imported into the gateway here
2. Add a volume to ignition service in docker compose that adds the module file into the `/modules` directory in the image.

    ```yaml
    services:
      gateway:
        volumes:
          - ./module-init/Module-Name.modl:/modules
    ```

  > [!NOTE]
  > The custom Ignition image used in this project has a volume mounted to `/modules` that will automatically import any .modl files in the directory.
