# SLSKX

SLSKX is a self-hosted Soulseek client built with Elixir and the Phoenix Framework.

## Getting Started

### Environment Variables

#### Soulseek Network Configuration

| Variable                       | Default           | Description                                       |
| ------------------------------ | ----------------- | ------------------------------------------------- |
| `SOULSEEK_USERNAME` (required) |                   | your Soulseek username                            |
| `SOULSEEK_PASSWORD` (required) |                   | your Soulseek password                            |
| `SOULSEEK_SERVER_HOST`         | `vps.slsknet.org` | the hostname of the Soulseek server to connect to |
| `SOULSEEK_SERVER_PORT`         | `2271`            | the port of the Soulseek server to connect to     |

#### SLSKX Client Configuration

| Variable               | Default                               | Description                                    |
| ---------------------- | ------------------------------------- | ---------------------------------------------- |
| `SLSKX_USERNAME`       |                                       | the username for accessing the web UI          |
| `SLSKX_PASSWORD`       |                                       | the password for accessing the web UI          |
| `SHARED_DIRECTORIES`   |                                       | a comma separated list of directories to share |
| `COMPLETE_DIRECTORY`   | `/var/lib/slskx/downloads/complete`   | a directory to save downloaded files           |
| `INCOMPLETE_DIRECTORY` | `/var/lib/slskx/downloads/incomplete` | a directory to save incomplete downloads       |

#### SLSKX Web Configuration

| Variable                | Default | Description                                                        |
| ----------------------- | ------- | ------------------------------------------------------------------ |
| `SLSKX_SECRET_KEY_BASE` |         | (required) a secret used to sign/encrypt cookies and other secrets |
| `SLSKX_HTTP_PORT`       | `4080`  | the listen port for HTTP (defaults to ``)                          |
| `SLSKX_HTTPS_PORT`      | `4443`  | the listen port for HTTPS (defaults to )                           |
| `SLSKX_WEB_SCHEME`      |         | URL scheme used for generating URLs throughout the app             |
| `SLSKX_WEB_HOST`        |         | URL host used for generating URLs throughout the app               |
| `SLSKX_WEB_PORT`        |         | URL port used for generating URLs throughout the app               |
| `SLSKX_WEB_PATH`        |         | URL path used for generating URLs throughout the app               |

#### Database Configuration

| Variable             | Default    | Description                                      |
| -------------------- | ---------- | ------------------------------------------------ |
| `DATABASE_USERNAME`  | `slskx`    | database username                                |
| `DATABASE_PASSWORD`  | `slskx`    | database password                                |
| `DATABASE_HOST`      | `postgres` | database host                                    |
| `DATABASE_PORT`      | `5432`     | database port                                    |
| `DATABASE_NAME`      | `slskx`    | database name                                    |
| `DATABASE_URL`       |            | database connection url, overrides other configs |
| `DATABASE_POOL_SIZE` | `10`       | size of the pool used by the connection module   |
