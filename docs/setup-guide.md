# Setup Guide

## Table of Contents

- [Setup Guide](#setup-guide)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Initial setup](#initial-setup)
  - [Update the stack](#update-the-stack)
  - [Add project basics](#add-project-basics)

## Introduction

> [!TIP]
> This guide is only needed for the _first_ time the project is set up using the template. If you are contributing to the project, refer to the [Quickstart Guide](./quickstart-guide.md).

This guide is meant to help you understand what's here and how to use it. This is for new projects and only needs to be done once. At the end of this guide, you should have a working development stack that your team can use to develop, build, and test applications! 

This stack is built using several tools and technologies, including Docker, Docker Compose, Git version control, and WSL (for Windows users). If you are not familiar with these tools, please review the [Ignition version control](https://github.com/ia-eknorr/ignition-version-control) documentation to get a better understanding of how they work and how they are used with Ignition.

## Initial setup

1. [Verify your workstation is set up properly](https://github.com/ia-eknorr/ignition-version-control/blob/main/Workstation%20Setup.md)
2. If you are a Windows user, you will need to install WSL2 and Docker on WSL. Follow the instructions in the [Windows Setup Guide](https://github.com/ia-eknorr/ignition-version-control/blob/main/Set%20Up%20WSL.md)
3. Verify that you have the necessary software installed on your workstation.
   - [Docker](https://docs.docker.com/get-docker/)
4. Click "Use this template" to create a new repository from this template.

   - Follow the [Style Guide](https://github.com/ia-eknorr/ignition-git-style-guide?tab=readme-ov-file#repository-setup-1) to set up your repository.

5. Clone the repository to your local machine.

    ```bash
    cd <path-to-your-workspace>
    git clone <github-repository-link>
    ```

## Update the stack

> [!NOTE]
> This will be different for each project. Below are suggested changes, but not everything may be applicable.

1. `initialize.sh`
   Update, add, or delete environment variables that are created when running `initialize.sh`. This is used to create the `.env` file, among other things.

2. `db-init`
   Place .sql files containing database instantiation in the following folders. These sql scripts will be be run alphanumerically on startup. See [`db-init/README.md`](../db-init/README.md) for more information.

3. `README.md`

   > [!TIP]
   > Your project should have a readme that contains information about the project, helpful links, and anything else you think would be useful. `README.md` has a starting point for you, but you should update it with pertinent information for the project.

4. `docs` (Optional)
   - Place any useful or pertinent documentation to your project here, such as an `installation-guide.md`

5. `module-init` (Optional)

   - Used for any necessary 3rd party modules.
   - See [`module-init/readme.md`](/module-init/README.md) to learn more about how to use this folder.

## Add project basics

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

    > [!TIP]
    > Starting up the stack will create a new directory for each ignition service. This will have the `projects` directory inside, as well as the `modules` directory. For more information on how to use the derived Ignition image, see the [Common Docker Ignition Image documentation](https://github.com/inductive-automation/common-docker-ignition)

4. Browse to the following URLs to access the application:

    `<service-name>.localtest.me`

5. Add project basics

   - Create a new project
     - New project changes will automatically be shown in the `projects` directory within the Ignition service data directory
   - Update gateway settings
     - Use the [backup script](../scripts/README.md#download-gateway-backupssh) to download the gateway backup and strip out the projects
   - Add tags
     - Use the [tag export script](../scripts/README.md#scriptsexport-all-tagssh) to export all tags from the gateway into the `tags` directory.

6. Add and commit changes

    ```bash
    git add .
    git commit -m "Initial commit"
    git push origin main
    ```

7. Tell your team to clone the repository and follow the [Quickstart Guide](./quickstart-guide.md) to get started!
