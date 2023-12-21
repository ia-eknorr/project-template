# Project Template

## Purpose

This project template has been specifically curated for use by the Public Demo team as a base repository for demo vertical development projects, although this can be used and adapted for many projects

## How To Use

### Instantiate this template repo

1. Navigate to [this](https://github.com/inductive-automation/demo-vertical-base) base repository
2. Select "Use this template"
   * Include all branches: `False`
   * Owner: `inductive-automation`
   * Repository Name: `<unique-repository-name`
   * Internal/Private: `Private`
   * "Create repository"
3. Create local repository
   * Create folder for repository
   * Run `git clone <repository-link>`

### Update the stack

> :memo: **_Note_**: This will be different for each project. Below are recommended changes, but not everything may be applicable.

1. `.env`
   | Variable           | Value                          |
   |--------------------|--------------------------------|
   | `ENV`              | "dev", "test", "prod"          |
   | `GATEWAY_NAME`     | "demo-vertical-<vertical-name>"|
   | `IGNITION_VERSION` | "8.1.x"                        |
   | `IGNITION_PROJECT` | "VerticalProjectName"          |
   | `MYSQL_VERSION`    | "8.0.33"                       |
   | `MYSQL_USER`       | "ignition"                     |
   | `MYSQL_PASSWORD`   | "ignition"                     |
   | `MYSQL_DATABASE`   | "VerticalDbName"               |

2. `db-init`
   > :memo: **_Note_**: Sub-folders `db-setup`, `tables`, and `seed-data` can each contain any number of .sql files, based on how it best makes sense to organize the project. During stack startup, scripts in these folders will be executed in batch in the following order: `db-setup`, `tables`, `seed-data`. During batch execution, scripts within each folder will be run alphanumerically. See the default files `db-init` for a full example.

   * `db-init/db-setup`
      * Create databases
      * Create users
      * Grant permissions
   * `db-init/tables`
      * Create tables in database
   * `db-init/seed-data`
      * Insert initial data needed for the project

3. `gw-projects`
   * For a new project
      * Update `ExampleProject/project.json` with `title: "<NewProjectName>"`
      * Rename `ExampleProject` directory with `<NewProjectName>`
   * For an existing project
      * Delete `gw-projects/ExampleProject` and replace it with the existing _unzipped_ project export.

4. Add secrets to github repository
   > :memo: **_Note_** This must be done in order for the `publish-and-update.yml` workflow to run properly. See FAQ below for more information.

   * Open Github project repository
   * Navigate to Settings > Secrets and variables > Actions
   * Add "New repository secret"
     * Name: `PUBLIC_DEMO_DEV_TOKEN`
     * Secret: As @ia-eknorr for access to 1pass link
   * Click "Add secret"

5. `readme.md`
   > :memo: **_Note_**: Your project should have a readme that contains information about the project, helpful links, and anything else you think would be useful. `sample-readme.md` has been added as an example.

   * Update `sample-readme.md` with pertinent information for the project.
   * Delete (or rename) this document, `readme.md`.
   * Rename `sample-readme.md` to `readme.md`.

6. `docs` (Optional)
   * Place any useful or pertinent documentation to your project here, such as an `installation-guide.md`

7. `module-init` (Optional)

   * Used for any necessary 3rd party modules.
   * See `module-init/readme.md` to learn more about how to use this folder.

8. `secrets` (Optional)
   * Used for sensitive information like passwords, tokens, etc.
   * See `secrets/readme.md` to learn more about how to use this folder.

### Finish stack setup

1. Commit and push stack changes

   ```bash
   cd /path/to/project
   git add .
   git commit -m "Feature: Update base stack for <ProjectName> project"
   git push origin main
   ```

2. Spin up the stack

   ```bash
   cd /path/to/project
   docker-compose up -d
   ```

### FAQ

**How can I connect to a database management software like MySQL Workbench?**

* In `docker-compose.yml`, uncomment services.mysql-db.ports and the definition of ports on the next line.
* Adjust the port to desired port map
* Run `docker-compose up -d` to update the stack.

**What is `scripts/create-release-package`?**

When a new release is made, the github workflow `publish-and-update` is run. This wraps up the project into a package that can be uploaded to the Ignition Exchange and updates the Public Demo repository with the latest release. For most Vertical Demo Stacks, this shouldn't need to be updated. Ask @ia-eknorr for more information.

**How can I use a different version of MySQL other than 8.0.33?**

* Replace `db-init/mysql-connector-j-8.0.33.jar` with the appropriate driver for the version.
* In `docker-compose.yml`, update `services.liquibase.volumes` with the updated _relative path_ for the driver, as well as the location in the container on this same line.
* Run `docker-compose up -d` to update the stack.
