# Project Template

## Purpose

This project template is designed as a base repository for any project, and can be adapted for any purpose.

## Getting started

If you are new to version control or just haven't used it in awhile, the following documents may be useful to get you started.

* [Git Style Guide](https://github.com/ia-eknorr/ignition-git-style-guide)
* [IA Version Control Documentation](https://github.com/ia-eknorr/ignition-version-control)

It is assumed that the following have been installed and set up before spinning up this stack:

* [Proper workstation setup](https://github.com/ia-eknorr/ignition-version-control/blob/main/Workstation%20Setup.md)
  * Git
  * Github CLI
  * Visual Studio Code
* Docker
* [Traefik reverse proxy](https://github.com/ia-eknorr/traefik-reverse-proxy)

## How To Use

### Create local repository

* Create folder for repository
* Run `git clone <repository-link>`

### Update the stack

> [!NOTE]
> This will be different for each project. Below are suggested changes, but not everything may be applicable.

1. `initialize.sh`
   Update, add, or delete environment variables that are created when running `initialize.sh`. This is used to create the `.env` file, among other things.

2. `db-init`
   Place .sql files containing database instantiation in the following folders. These sql scripts will be be run alphanumerically on startup.

3. `readme.md`

   > [!TIP]
   > Your project should have a readme that contains information about the project, helpful links, and anything else you think would be useful. `sample-readme.md` has been added as an example.

   * Update `sample-readme.md` with pertinent information for the project.
   * Delete (or rename) this document, `readme.md`.
   * Rename `sample-readme.md` to `readme.md`.

4. `docs` (Optional)
   * Place any useful or pertinent documentation to your project here, such as an `installation-guide.md`

5. `module-init` (Optional)

   * Used for any necessary 3rd party modules.
   * See [`module-init/readme.md`](/module-init/readme.md) to learn more about how to use this folder.

6. `secrets` (Optional)
   * Used for sensitive information like passwords, tokens, etc.
   * See [`secrets/readme.md`](/secrets/readme.md) to learn more about how to use this folder.

### Note for Windows/Linux Users

In order for the symlinks to work, you must first create an empty folder adjacent to the `docker-compose.yml` file that has the same name as the desired bind mount. On Windows/Linux docker will automatically do everything as `root`, so without doing this the created file will be owned by `root:root` instead of `user:user`. On a Mac, this is not necessary, MacOS ftw.

So for example, if you have a bind mount for `./data-gateway:/workdir`, you would need to create a folder named `data-gateway` in the same directory as the `docker-compose.yml` file.

### Finish stack setup

1. Commit and push stack changes

   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. Initialize the stack

   ```bash
   bash initialize.sh
   ```

3. Spin up the stack

   ```bash
   docker-compose up -d
   ```

4. Start development!
   * Make gateway changes
   * Create projects

## Updating this Development Environment

The configuration baked into each of the `gw-init/*.gwbk` gateway files is setup to connect to other development resources in this environment. When updating elements of the base configuration, it is important that the projects are not part of the captured GWBK's. Below are two sequences of steps to update the environment's GWBK's (depending on system):

### MacOS and Windows WSL

1. Bring the solution online and make the needed configuration changes.
2. Run the following script to take a gateway backup of the container and strip the gateway projects

   ```bash
   bash scripts/download-gateway-backups.sh
   ```

3. Commit the new backup to source control.

### Windows with Docker Desktop

1. Bring the solution online and make the needed configuration changes.
2. Take a gateway backups and **replace** the .gwbk in `gw-init/`.
3. Run the following command to strip out the projects from all .gwbk files in the `gw-init` directory:
   * On Windows Powershell:

        ```bash
        docker run --rm -u root -v ${PWD}\gw-init:/gw-init -it --entrypoint bash inductiveautomation/ignition:8.1.42 -c "cd /gw-init; ./strip-projects-from-gwbk.sh -a"
        ```

   * On Windows CMD:

        ```bash
        docker run --rm -u root -v %cd%\gw-init:/gw-init -it --entrypoint bash inductiveautomation/ignition:8.1.42 -c "cd /gw-init; ./strip-projects-from-gwbk.sh -a"
        ```

4. The output should reflect whether any projects folders were removed from the .gwbk's.  They're now ready to commit to source control.
5. Commit the new backup to source control.

### FAQ

**How can I connect to a database management software like PGAdmin?**

* In `docker-compose.yml`, uncomment services.db.ports and the definition of ports on the next line.
* Adjust the port to desired port map
* Run `docker-compose up -d` to update the stack.

### Questions? Requests?

If you have any questions or notice something that doesn't look right, open an issue or submit a pull request.

### Cred

Much inspiration for all of this was taken from [Kevin Collins](https://github.com/thirdgen88) as well as [Design Group](https://github.com/design-group). There is nothing here they haven't already done, I just put it in one place.
