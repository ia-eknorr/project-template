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
- **config-cleanup** - Removes generated config files not meant for version control

The gateway is exposed via [Traefik](https://traefik.io/) at `${GATEWAY_NAME}.localtest.me`.
Traefik must be running before starting this stack - see the
[setup guide](https://ia-eknorr.github.io/ignition-guides/docs/getting-started/traefik) for
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

For a full walkthrough see the [Hands-On Lab](https://ia-eknorr.github.io/ignition-guides/docs/labs/git-ignition-lab).

## Version Control

The two bind-mounted directories in your repo are tracked in Git:

| Directory | Contents |
| --- | --- |
| `services/ignition/projects/` | Ignition projects |
| `services/ignition/config/resources/core/` | Shared gateway config |
| `services/ignition/config/resources/dev/` | Dev environment config |

Changes made in the Ignition Designer appear instantly in these directories - no export step needed.

## Linting

Pull requests run shellcheck, markdownlint, yamllint, and ignition-lint automatically. See the
[ignition-guides](https://ia-eknorr.github.io/ignition-guides/) for details.
