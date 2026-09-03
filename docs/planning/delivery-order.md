# Delivery Order

## Epic 1 — Foundation

Finish database supervision, environment documentation, password-only web authentication, `/health`, Docker development stack, test helpers, and basic PR checks.

## Epic 2 — Protocol Codec

Build the pure binary codec before networking. Each supported message has encode/decode round-trip tests plus malformed/truncated input tests. The codec owns framing and bounded decoding; networking owns sockets and reconnection.

GitHub stories #8–14 need acceptance criteria before implementation. They must identify the supported messages, wire-code mapping, direction, field encoding, maximum decoded sizes, and test cases.

## Epic 3 — Server Connection and Session

Add the supervised server socket, login, framing dispatch, keepalive, bounded exponential reconnect, `Relogged` terminal state, connection event telemetry, message counters, and a configurable inbound peer listener. Test it against a local TCP test server; do not add a transport abstraction until a second real transport exists.

## Epic 4 — Search and Remote Browse

Provide server search dispatch, streamed result storage, basic filtering/sorting, remote share-list requests, and a small LiveView search surface. Search and share browsing use Epic 2 codecs and Epic 3 connection ownership; they do not open unmanaged sockets.

## Epic 5 — Transfers

Start with direct peer connections and basic queued downloads/uploads. Indirect fallback, pause/resume, throttling schedules, webhooks, and command hooks follow after the direct path is exercised end to end.

## Epics 6–9 — User Features

Build chat, shares, buddies, and wishlists only after the server/peer lifecycle is reliable. Each feature may add the smallest persistent setting it needs; it must not wait for the full settings UI.

## Epic 10 — Settings and Operations

Centralize the existing settings, build the full UI, diagnostics, history, navigation, and optional notifications. The `settings` persistence and environment-override lookup needed by earlier epics is introduced when its first consumer needs it, not delayed to this epic.

## Epics 11–12 — API and Delivery Automation

Expose only already-existing domain operations through the API. Add OpenAPI after routes stabilize. Keep release and hotfix automation after the base CI workflow is reliable.
