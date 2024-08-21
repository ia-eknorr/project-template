# Contributing Guide

## Introduction

The purpose of this document is to provide guidelines for contributing to the project. This includes setting up the development environment, making changes, and submitting pull requests. If this is a new project, follow the [Setup Guide](./docs/setup-guide.md) to get started.

## Initial setup

If you have previously used the standard SE project template, this should be done already. If not, follow these steps to set up your development environment.

1. [Verify your workstation is set up properly](https://github.com/ia-eknorr/ignition-version-control/blob/main/Workstation%20Setup.md)
2. If you are a Windows user, you will need to install WSL2 and Docker on WSL. Follow the instructions in the [Windows Setup Guide](https://github.com/ia-eknorr/ignition-version-control/blob/main/Set%20Up%20WSL.md)
3. Verify that you have the necessary software installed on your workstation.
   - [Docker](https://docs.docker.com/get-docker/)
4. Clone the repository to your local machine.

    ```bash
    cd <path-to-your-workspace>
    git clone <github-repository-link>
    ```

> [!WARNING] Additional setup for Windows/Linux users
> Check the [docker-compose.yml](../docker-compose.yml) file for any bind mounts to `/workdir`. In order for the symlinks to work, you must first create an empty folder adjacent to the `docker-compose.yml` file that has the same name as the desired bind mount. On Windows/Linux docker will automatically do everything as `root`, so without doing this the created file will be owned by `root:root` instead of `user:user`. On a Mac, this is not necessary, MacOS ftw.
>
> So for example, if you have a bind mount on an Ignition service for `./data-gateway:/workdir`, you would need to create a folder named `data-gateway` in the same directory as the `docker-compose.yml` file.

## Spinning up the stack

1. Open a terminal and navigate to the root of the repository.

    ```bash
    cd <path-to-your-workspace>/<project-name>
    ```

2. Run the initialization script to set up the `.env` file and install the necessary tools.

    ```bash
    bash ./initialize.sh
    ```

3. [Optional] During initialization, if you opted to not startup the stack, or if you ran into an issue, you can start the stack by running the following command:

    ```bash
    docker compose up -d
    ```

    > [!NOTE]
    > `docker compose` is the new command for `docker-compose`. If you are using an older version of Docker, you may need to use `docker-compose` instead. Consider upgrading to the latest version of Docker to use the latest features.

4. Browse to the following URLs to access the application:

    `<service-name>.localtest.me`
    
## Pre-commit hooks

This project uses pre-commit hooks to ensure that code is formatted correctly before committing. While not required, it can be helpful to install the pre-commit hooks to ensure that your code is formatted correctly before pushing changes.

- To install the pre-commit hooks, run the following command:

    ```bash
    pre-commit install
    ```

- To run the pre-commit hooks manually, run the following command:

    ```bash
    pre-commit run --all-files
    ```

- To uninstall the pre-commit hooks, run the following command:

    ```bash
    pre-commit uninstall
    ```

- To skip the pre-commit hooks, add the `--no-verify` flag to the `git commit` command.

    ```bash
    git commit -m "Your commit message" --no-verify
    ```

## Making changes

> [!NOTE]
> Before making changes, review the [Git Style Guide](https://github.com/ia-eknorr/ignition-git-style-guide) to ensure your branches, commits, and pull requests follow the established conventions.
>
> If you need a reminder on some of the Git commands, refer to the [Ignition Version Control](https://github.com/ia-eknorr/ignition-version-control) guide.

1. Create a new branch from the `main` branch.

    ```bash
    git checkout -b <branch-name>
    ```

2. Make changes to the codebase
   - **Project changes**: These will be reflected in the `projects` directory within the Ignition service data directory and can be committed directly.
   - **Gateway setting updates**: Use the [gateway backup script](../scripts/README.md#download-gateway-backupssh) to download the gateway backup and strip out the projects.
   - **Tag changes**: Use the [tag export script](../scripts/README.md#scriptsexport-all-tagssh) to export all tags from the gateway into the `tags` directory.

3. Commit changes

    ```bash
    git add .
    git commit -m "Your commit message"
    ```

4. Push changes to the remote repository

    ```bash
    git push origin HEAD
    ```

## Submitting a pull request

1. Open a pull request on GitHub
2. Fill out the pull request template
3. Assign a reviewer
4. Wait for the reviewer to approve the pull request
5. Merge the pull request

## Common Docker Stack Operations

### Basic Stack Commands

- Bring up the stack:

    ```bash
    docker compose up -d
    ```

- Take down the stack without removing the volumes:

    ```bash
    docker compose down
    ```

- Take down the stack and remove any orphaned containers:

    ```bash
    docker compose down --remove-orphans
    ```

### Log and Shell Commands

> [!TIP]
> Service names are defined in the [`docker-compose.yml`](../docker-compose.yml) file under `services`:
> 
> - `gateway`
> - `db`

- View logs for a specific service:

    ```bash
    docker compose logs <service-name>
    ```

- Shell into a running container:

    ```bash
    docker compose exec -it <service-name> /bin/bash
    ```

### FAQ

**How can I connect to a database management software like PGAdmin?**

- In `docker-compose.yml`, uncomment `services.db.ports` and the definition of ports on the next line.
- Adjust the port to desired port map
- Run `docker-compose up -d` to update the stack.
- Connect to the database using the hostname of the database service and the port you defined.
