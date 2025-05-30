# `gw-init` directory

## Contents

The contents of this directory are to be gateway backups from relevant ignition services defined in the `docker-compose.yml` file found in the root directory. These gateway backups ought to have the projects stripped from the .gwbk file. It is recommended to use the gateway backup helper script [`scripts/download-gateway-backups.sh`](../scripts/download-gateway-backups.sh). More information about how to use this script can be found in the [scripts README](../scripts/README.md#download-gateway-backupssh)

## Usage

### Updating Gateway Backups

1. Make gateway changes in the Ignition gateway.
2. Run the following command to update the gateway backups:

    ```bash
    scripts/download-gateway-backups.sh
    ```

    This script will search for running ignition services in the compose stack, take a gateway backup, unzip the backup, delete the `projects` directory, re-zip the backup, and move the backup into the `gw-init` directory. The backups found in the `gw-init` directory can then be committed to the repository. Gateway backups are named according to the service name in the compose stack.

    > [!NOTE]
    > This script only works in unix environments. If you are using a Windows environment, you can run the script in a WSL environment. To set up WSL, [follow the instructions](https://github.com/ia-eknorr/ignition-version-control/blob/main/Set%20Up%20WSL.md).

3. Add and commit the updated gateway backups to the repository.

    > [!TIP]
    > If you wish to only keep certain backups, you can restore the backups you do not wish to update and commit the others.
