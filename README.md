# project-template

A base repository template for Ignition 8.3 projects using Docker Compose. Fork this to get a
pre-configured gateway stack with bind-mounted project and config directories ready for Git
version control.

## Branches

| Branch | Ignition Version | Status |
| --- | --- | --- |
| `main` | 8.3 (Docker, Traefik, PostgreSQL) | Active |
| `release/v1` | 8.1 (legacy) | Maintenance only |

## Stack

The `main` branch runs an Ignition 8.3 stack:

- **gateway** - Ignition gateway with bind-mounted `projects/` and `config/resources/`
- **db** - PostgreSQL database
- **bootstrap** - One-time setup script (runs on first start)

The gateway is exposed via [Traefik](https://traefik.io/) at `${GATEWAY_NAME}.localtest.me`.
Traefik must be running before starting this stack - see the
[setup guide](https://etknorr.github.io/ignition-guides/docs/getting-started/traefik) for
instructions.

## Quick Start

1. Click **Use this template** on GitHub to create your own repository
2. Clone your new repo and copy the environment file:

   ```shell
   git clone <your-repo-url>
   cd <repo-folder>
   cp .env.example .env
   ```

3. Edit `.env` and set `GATEWAY_NAME` to a short identifier (e.g., `dev-gw`)
4. Start the stack:

   ```shell
   docker compose up -d
   ```

5. Open `http://${GATEWAY_NAME}.localtest.me` in your browser

For step-by-step walkthroughs using this template, see ignition-guides:

- [Docker Lab](https://etknorr.github.io/ignition-guides/docs/labs/docker-ignition-lab) - start here. Bring the gateway up, watch each service boot, and practice day-two operations.
- [Version Control Lab](https://etknorr.github.io/ignition-guides/docs/labs/version-control-lab) - track this project in Git with branches, pull requests, and merges.
- [Helm Lab](https://etknorr.github.io/ignition-guides/docs/labs/helm-ignition-lab) - deploy Ignition to a local Kubernetes cluster using the official Helm chart.

## Version Control

The two bind-mounted directories in your repo are tracked in Git:

| Directory | Contents |
| --- | --- |
| `services/ignition/projects/` | Ignition projects |
| `services/ignition/config/resources/core/` | Shared gateway config |
| `services/ignition/config/resources/dev/` | Dev environment config |

Changes made in the Ignition Designer appear instantly in these directories - no export step needed.

## Security

By design, this template ships with the Gateway open: no login is required to browse the
Gateway UI. This is the stock behavior of `security-properties/config.json` shipped in this
repo, where `accessPermissions`, `readPermissions`, and `writePermissions` all use an empty
`AnyOf` list (no security levels required). It avoids the situation where a new user clones
the template, brings the stack up, and has no way to know what credentials to use.

The committed admin user still exists in
`services/ignition/config/resources/core/ignition/user-source/default/users.json`. You only
need to authenticate for operations that require an `Administrator` role (such as launching
the Designer).

> [!WARNING]
> While the Gateway is open, the user-management UI is also unauthenticated. Anyone with
> network access to the Gateway can change the `admin` password through the UI without
> first proving they know the existing one. Treat the open-by-default Gateway as a local
> development convenience only.

### Locking the Gateway Down

Before any non-local deployment, change the `admin` password and require the
`Authenticated` security level on the Gateway's Access/Read/Write permissions. Both
are under `Platform -> Security` in the Gateway web UI.

## Linting

Pull requests run [shellcheck](https://www.shellcheck.net/), [markdownlint](https://github.com/DavidAnson/markdownlint), [yamllint](https://yamllint.readthedocs.io/), and [ignition-lint](https://etknorr.github.io/ignition-guides/docs/tools/ignition-lint) automatically. To run them locally before pushing, install [pre-commit](https://pre-commit.com/) and run `pre-commit run --all-files`. The configuration lives in `.pre-commit-config.yaml`.

## License

This project is licensed under the [MIT License](LICENSE).
