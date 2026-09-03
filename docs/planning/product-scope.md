# Product Scope

This document resolves conflicts between the early requirements, Epic 1 draft, and GitHub issues. It is the planning source of truth until the original requirement and epic documents are committed and updated.

## MVP

A self-hosted user can sign in, connect to Soulseek, search, browse shares, queue a direct download, serve a basic upload, and use room/private chat.

The MVP includes:

- password-only web authentication, health endpoint, Docker development stack, and basic PR checks;
- pure, bounded codecs for the Soulseek messages SLSKX supports;
- supervised server connection, login, reconnect, `Relogged` handling, and inbound peer listener;
- direct peer connections, basic transfer queue/progress, and basic shared-folder indexing;
- search, room chat, and private messages.

## Deferred Until the MVP Works

- indirect peer fallback, transfer pause/resume, scheduled bandwidth limits, post-download webhooks, and shell hooks;
- private rooms, room tickers, global-room feeds, recommendations, browser push notifications, and filesystem watching;
- REST endpoints, generated OpenAPI, release/hotfix automation, and coverage enforcement.

Deferred features remain valid requirements; they are not implementation prerequisites.

## Authentication

- The web UI uses `SLSKX_WEB_PASSWORD` only. There is no web username.
- Login is a server-rendered `GET /login` form posting to `POST /session`; logout is `DELETE /logout`.
- Password comparison uses `Plug.Crypto.secure_compare/2` after equal-length validation.
- Auth may be disabled only in development and test when the password is unset. Production startup fails if it is unset.
- Do not introduce an auth strategy behaviour until a second strategy is an approved feature.

## Cross-Cutting Safety Rules

- Codec decoding sets maximum frame, string, collection, and file-size limits. Unknown message codes fail safely and are logged without crashing a connection supervisor.
- Peer connections and transfer queues have explicit connection, queue-depth, and timeout limits.
- Downloads must resolve within the configured download root; reject traversal and symlink escapes. Write to a temporary file and atomically rename only after a successful transfer.
- Shared paths must resolve within configured share roots. Never expose arbitrary filesystem paths.
- Any future webhook is opt-in and has connect/read timeouts. Any future command hook receives an executable and fixed argv; never invoke a shell or interpolate a filename into a command string.

## CI

Start with a PR workflow that runs formatting, Credo, unit tests, and a Docker build. Add integration services and a coverage threshold once the project has meaningful integration coverage.
