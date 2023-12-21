# My Project Development Stack

This repository will be used as a development stack for...

## Reference Docs

* [Git Style Guide](https://github.com/ia-eknorr/ignition-git-style-guide)
* [IA Version Control Documentation](https://github.com/ia-eknorr/ignition-version-control)

## Requirements

* [Proper workstation setup](https://github.com/ia-eknorr/ignition-version-control/blob/main/Workstation%20Setup.md)
  * Git
  * Github CLI
  * Visual Studio Code
* Docker
* [Traefik reverse proxy](https://github.com/ia-eknorr/traefik-reverse-proxy)
* [Optional] PGAdmin

     <details>
     <summary>Example Docker Compose</summary>

      version: '3.8'

      services:
        pgadmin:
        image: dpage/pgadmin4
        container_name: pgadmin
        environment:
          PGADMIN_DEFAULT_EMAIL: my-email@example.com
          PGADMIN_DEFAULT_PASSWORD: ignition
        ports:
          - "5050:80"
        labels:
          - traefik.enable=true
          - traefik.hostname=pgadmin
        restart: always
        volumes:
          - pgadmin-data:/var/lib/pgadmin
        networks:
          - default

      networks:
        default:
          external: true
          name: proxy

      volumes:
        pgadmin-data:

</details>

## How to use

1. Clone Demo Project git repository

    ```bash
    cd /path/to/project
    git clone <github-repository-link> .
    ```

    > :memo: **_Note_**: It is recommended that the `path/to/project` mentioned above is organized as `projects/active/my-project-name`, or similar project name.

2. Spin up Docker stack

    ```bash
    docker-compose up -d
    ```

3. Open gateway

    **Example**

    [http://example-gateway.localtest.me](http://example-gateway.localtest.me)

    or

    [container-name].localtest.me

    Container name(s) can be checked in Docker Desktop or by the following command

    ```bash
    docker ps
    ```

## Recreating your environment

In some cases a recreation of the development environment may be necessary. Here are some examples cases:

* New gateway backup
* Update to the database schema or seed data

Run the following commands in the terminal one at a time to recreate the development environment:

```bash
# Path where your docker-compose.yml file is
cd /path/to/project
# Spin down the containers and remove volumes
docker-compose down -v
# Recreate new containers and volumes
docker-compose up -d
```

## Updating this Development Environment

The configuration baked into each of the `gw-init/*.gwbk` gateway files is setup to connect to other development resources in this environment.  When updating elements of the base configuration, it is important that the projects are not part of the captured GWBK's.  Below is a sequence of steps to update the environment's GWBK's:

1. Bring the solution online and make the needed configuration changes.
2. Run `download-gateway-backups.sh`
   1. This will go to each running ignition gateway, take backups, strip projects from the backup, and place them in the `gw-init` folder

    ```bash
    cd /path/to/project
    bash download-gateway-backups.sh
    ```
