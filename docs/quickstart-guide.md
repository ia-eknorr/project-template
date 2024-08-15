# Setup Guide

## Table of Contents

- [Setup Guide](#setup-guide)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Initial setup](#initial-setup)
  - [Spinning up the stack](#spinning-up-the-stack)
  - [Stopping the stack](#stopping-the-stack)
  - [About volumes](#about-volumes)
  - [Common Docker Stack Operations](#common-docker-stack-operations)
    - [Viewing logs](#viewing-logs)
  - [Contributing](#contributing)
  - [Testing](#testing)

## Introduction

This guide is meant to help you understand what's here and how to use it, starting from the ground up. At the end of this guide, you should have a working development stack that you can use to develop, build, test, and deploy the Demo POC application.

This stack is built using several tools and technologies, including Docker, Docker Compose, Git version control, and WSL (for Windows users). If you are not familiar with these tools, please review the [Ignition version control](https://github.com/ia-eknorr/ignition-version-control) documentation to get a better understanding of how they work and how they are used with Ignition.

## Initial setup

1. [Verify your workstation is set up properly](https://github.com/ia-eknorr/ignition-version-control/blob/main/Workstation%20Setup.md)
2. If you are a Windows user, you will need to install WSL2 and Docker on WSL. Follow the instructions in the [Windows Setup Guide](https://github.com/ia-eknorr/ignition-version-control/blob/main/Set%20Up%20WSL.md)
3. Verify that you have the necessary software installed on your workstation.
   - [Docker](https://docs.docker.com/get-docker/)
4. Clone the repository to your local machine.

    ```bash
    cd <path-to-your-workspace>
    git clone <github-repository-link>
    ```

## Spinning up the stack

1. Open a terminal and navigate to the root of the repository.

    ```bash
    cd <path-to-your-workspace>/<project-name>
    ```

2. Run the initialization script to set up the `.env` file and install the necessary tools.

    ```bash
    bash ./initialize.sh
    ```

3. [Optional] During initialization, if you opted to not startup the stack, if you applied the license and token, or if you ran into an issue, you can start the stack by running the following command:

    ```bash
    docker compose up -d
    ```

    > [!NOTE]
    > `docker compose` is the new command for `docker-compose`. If you are using an older version of Docker, you may need to use `docker-compose` instead. Consider upgrading to the latest version of Docker to use the latest features.

4. Browse to the following URLs to access the application:

    `<service-name>.localtest.me`

## Stopping the stack

1. Open a terminal and navigate to the root of the repository.

    ```bash
    cd <path-to-your-workspace>/<project-name>
    ```

2. Run one of following command to stop the stack:
    - To stop the stack without removing the volumes:

        ```bash
        docker compose down
        ```

    - To stop the stack and remove the volumes:

        ```bash
        docker compose down -v
        ```

    > [!TIP]
    > If you are having issues with the stack, you can try running the command with the `--remove-orphans` flag to remove any orphaned containers.

## About volumes

> [!TIP] TL;DR
> It is almost always recommended to use the `-v` flag to remove volumes when taking down the stack. If you want to keep the gateway configs, you can run `docker compose down` without the `-v` flag.

This stack can be configured to use volumes to persist data between container restarts. When you run `docker compose down -v`, the volumes are removed. This is useful when you want to start fresh with a clean slate. If you want to keep the data, you can run `docker compose down` without the `-v` flag.

When spinning up the stack, Ignition stores its data in a volume that will persist if the container is removed. This is useful for development purposes, such that if you need to restart your stack, you won't lose your data. For instance, if a gateway has been commissioned, or if a gateway backup has been restored, the data will persist between restarts. If you receive a new gateway backup that you want to have restored, the stack and volume will need to be removed. On startup, the new gateway backup will be restored to the gateway. 

For more information about volumes, see the [Docker documentation](https://docs.docker.com/storage/volumes/).

## Common Docker Stack Operations

### Viewing logs

- View logs for a specific service:

    ```bash
    docker compose logs <service-name>
    ```

  - Service names are defined in the [`docker-compose.yml`](../docker-compose.yml) file under `services`:
    - `backend`
    - `frontend`
    - `db`
- Take down the stack and remove the volumes:

    ```bash
    docker compose down -v
    ```

- Take down the stack without removing the volumes:

    ```bash
    docker compose down
    ```

- Take down the stack and remove the volumes, and remove any orphaned containers:

    ```bash
    docker compose down -v --remove-orphans
    ```

- Take down the stack and remove the volumes, and remove any orphaned containers, and remove any images:

    ```bash
    docker compose down -v --remove-orphans --rmi all
    ```

- Bring up the stack:

    ```bash
    docker compose up -d
    ```

## Contributing

Contribution guide coming soon...

## Testing

Local testing guide coming soon...
