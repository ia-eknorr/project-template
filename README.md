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

Before deploying this template anywhere that is not your local machine, complete both steps
below.

**1. Change the admin password.**

- Open the Gateway in your browser.
- In the left nav, go to `Platform` -> expand `Security` -> `User Sources`.
- On the `default` user source row, click the kebab (`show-more`) menu and choose
  `Manage Users`.
- In the drawer that opens, click the kebab on the `admin` row and choose `Edit`.
- Tick `Change Password`, enter the new password in both fields, and click `Save Changes`.
- Commit the updated `users.json` if you want the new credential baked into the template,
  or leave it in the runtime volume.

**2. Require authentication on the Gateway.**

Edit `services/ignition/config/resources/core/ignition/security-properties/config.json` and
replace the three permission blocks (`accessPermissions`, `readPermissions`,
`writePermissions`) so they require the `Authenticated` security level:

```json
"accessPermissions": {
  "securityLevels": [
    { "children": [], "name": "Authenticated" }
  ],
  "type": "AllOf"
},
"readPermissions": {
  "securityLevels": [
    { "children": [], "name": "Authenticated" }
  ],
  "type": "AllOf"
},
"writePermissions": {
  "securityLevels": [
    { "children": [], "name": "Authenticated" }
  ],
  "type": "AllOf"
}
```

Then restart the Gateway:

```shell
docker compose restart gateway
```

Once both steps are complete, the Gateway requires a valid login for any access:
anonymous visits to `/app/home`, `/app/platform/security/user-sources`, and the rest of
the Gateway UI return a "Not Authenticated" prompt or "Page Not Found".

> [!NOTE]
> `forceIdpAuth` (also in `security-properties/config.json`) does **not** control whether
> login is required. Per the Ignition docs it controls SSO behavior: when `true`, the
> Gateway always asks the IdP to re-authenticate the user by default, effectively
> disabling Single Sign-On. Flipping it does not open or close anonymous access on its
> own; the permission blocks above are what gate access.

## Linting

Pull requests run shellcheck, markdownlint, yamllint, and ignition-lint automatically. See the
[ignition-guides](https://ia-eknorr.github.io/ignition-guides/) for details.
