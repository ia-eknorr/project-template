# Project Template

## Purpose

This project template is designed as a base repository for any project, and can be adapted for any purpose.

## How To Use

### Create local repository

* Create folder for repository
* Run `git clone <repository-link>`

### Update the stack

> :memo: **_Note_**: This will be different for each project. Below are suggested changes, but not everything may be applicable.

1. `.env`
   Update, add, or delete these variables as needed. The ones currently in this file are added as examples.

2. `db-init`
   Place .sql files containing database instantiation in the following folders. These sql scripts will be be run alphanumerically on startup.

3. `gw-projects`
   * For a new project
      * Update `ExampleProject/project.json` with `title: "<NewProjectName>"`
      * Rename `ExampleProject` directory with `<NewProjectName>`
   * For an existing project
      * Delete `gw-projects/ExampleProject` and replace it with the existing _unzipped_ project export.

4. `readme.md`
   > :memo: **_Note_**: Your project should have a readme that contains information about the project, helpful links, and anything else you think would be useful. `sample-readme.md` has been added as an example.

   * Update `sample-readme.md` with pertinent information for the project.
   * Delete (or rename) this document, `readme.md`.
   * Rename `sample-readme.md` to `readme.md`.

5. `docs` (Optional)
   * Place any useful or pertinent documentation to your project here, such as an `installation-guide.md`

6. `module-init` (Optional)

   * Used for any necessary 3rd party modules.
   * See `module-init/readme.md` to learn more about how to use this folder.

7. `secrets` (Optional)
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

**How can I connect to a database management software like PGAdmin?**

* In `docker-compose.yml`, uncomment services.db.ports and the definition of ports on the next line.
* Adjust the port to desired port map
* Run `docker-compose up -d` to update the stack.
