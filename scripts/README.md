# `scripts` Directory

## Table of Contents

- [`scripts` Directory](#scripts-directory)
  - [Table of Contents](#table-of-contents)
  - [Contents and Usage](#contents-and-usage)
    - [`download-gateway-backups.sh`](#download-gateway-backupssh)
    - [`scripts/export-all-tags.sh`](#scriptsexport-all-tagssh)
    - [`scripts/tag-export.sh`](#scriptstag-exportsh)
    - [`scripts/tag-import.sh`](#scriptstag-importsh)

## Contents and Usage

### `download-gateway-backups.sh`

This script is the primary way that gateway backups are taken in this stack. The script runs `docker compose ps` to search for ignition services, runs a `docker exec` against each running Ignition Gateway in the compose stack, and takes a gateway backup. Then, it unzips the gwbk, deletes the `projects` directory, re-zips the backup, and moves the backup into the `gw-init` directory. This is all an automatic process - to use this script, run the following:

```bash
scripts/download-gateway-backups.sh
```

> [!WARNING]
> Alternate command for Windows users:
> 
> - On Windows Powershell:
>
>   ```bash
>   docker run --rm -u root -v ${PWD}\gw-init:/gw-init -it --entrypoint bash inductiveautomation/ignition:8.1.42 -c "cd /gw-init; ./strip-projects-from-gwbk.sh -a"
>    ```
>
> - On Windows CMD:
>
>   ```bash
>   docker run --rm -u root -v %cd%\gw-init:/gw-init -it --entrypoint bash inductiveautomation/ignition:8.1.42 -c "cd /gw-init; ./strip-projects-from-gwbk.sh -a"
>   ```

Then, simply commit the gateway backups found in `gw-init` that you wish to keep.

### `scripts/export-all-tags.sh`

This is a helper script that can be used to export tags from the gateway. Simply run the script and it will export all tags from the gateway into a structure of files and directories that mimic the tag structure in the project.

1. After tag changes have been made, run:

    ```bash
    bash scripts/export-all-tags.sh
    ```

    A structure of files and directories will be created that mimics the tag structure in the project.

    > Example:
    >
    > ```bash
    > .
    > └── tags
    >     ├── default
    >     │   ├── _types_
    >     │   │   └── myUdt.json
    >     │   └── Exchange
    >     │       └── myInstance.json
    >     └── my_provider
    >         ├── _types_
    >         │   └── anotherUdt.json
    >         └── Exchange
    >             └── anotherInstance.json     
    > ```


### `scripts/tag-export.sh`

The [export-all-tags.sh](#scriptsexport-all-tagssh) is built on this tag-export utility. This tag export script can be used for more advanced or specific use cases. For more information, see the script help.

```bash
scripts/tag-export.sh --help
```

### `scripts/tag-import.sh`

This is a script that can be used to import all tags from the tags directory into the gateway in more advanced or specific cases.  For more information, see the script help.

```bash
scripts/tag-import.sh --help
```
