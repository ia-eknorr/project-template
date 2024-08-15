# `tags` Directory

Tags are exported and imported into the tags directory. Design Group's Tag CICD module is leveraged for this task. This repository has the module set to export tags in separate files to more closely mirror the tag structure in the designer.

This environment uses Design Group's Tag CI/CD module, meaning tags can be exported and imported using the tag utilities found in the [`scripts`](../scripts/README.md) directory. Tags are saved in the `tags/` directory, and are imported during the image build when the docker-compose file is started, or when a build is triggered (see [build workflow](../.github/workflows/README.md#buildyml-build-and-push-ignition-application-images)). See [Design Group's Tag CICD Module](https://github.com/design-group/ignition-tag-cicd-module) for more information.

- `scripts/export-all-tags.sh`: The easiest way to export all tags from a running gateway. Simply run the script with no options to export tags from the backend gateway to `tags` directory.
- `scripts/import-all-tags.sh`: The easiest way to import all tags to a running gateway. Simply run the script with no options to import tags from the `tags` directory to the backend gateway.
- `scripts/tag-export.sh`: A tag export utility with flags and options to aid in accomplishing a tag export with greater flexibility.
- `scripts/tag-import.sh`: A tag import utility with flags and options to aid in accomplishing a tag import with greater flexibility.

## Usage

Manual `curl` commands _could_ be run from the command line to manually accomplish tag import and export using the Tag-CICD module, however tag utility scripts have been written to aid in the import/export process. For more information on the following scripts, see the [`scripts` README](../scripts/README.md).

While it is possible to add, remove, and edit tags from this repository, it is recommended to use the tag utility scripts mentioned above, it is recommended to make tag edits in the designer, then export changes to the repository. Consider the following workflow:

1. Open an Ignition Designer
2. Make tag changes in a tag provider that can be found as a sub-directory of the `tags` directory
3. In VSCode, run the following to trigger a tag export

    ```bash
    bash scripts/export-all-tags.sh
    ```

4. Verify that your tag changes have been saved in the `tags` directory.
5. Add and commit your changes to the repository.

## FAQ

### How do I add another tag provider?

1. Add a new tag provider in the Ignition Gateway webpage.
2. In VSCode, add a new directory that matches the name of the new tag provider in the gateway.
   1. For instance, if the new tag provider in the gateway is called `my-new-prov`, and already had another tag provider called `default`, that `tags` directory in this repository should look like this:

     ```bash
     .
     └── tags
         ├── default
         └── my-new-prov
    ```

3. Run the tag export utility

    ```bash
    bash scripts/export-all-tags.sh
    ```

    1. This script will run endpoints against the gateway and will expect that the subdirectories of `tags` are real tag providers in the gateway.
4. Take a new gateway backup to save the gateway configuration for the tag provider

    ```bash
    bash scripts/download-gateway-backups.sh
    ```

5. Add and commit all tag changes and new gateway backups.
