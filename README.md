# SLSKX

SLSKX is a self-hosted Soulseek client built with Elixir and the Phoenix Framework. 

## Local Development

A `docker-compose.yml` (added in Epic 1) wires up Postgres and a local Soulseek server via [soulfind](https://github.com/soulfind-dev/soulfind) for end-to-end testing without depending on the real Soulseek network:

```sh
# starts postgres
docker compose up -d
# install dependencies and setup db
mix setup
# start the server
mix phx.server
# or start with IEx
iex -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.