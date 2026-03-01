# Contributing

## Running Locally

```sh
# start postgres
docker compose up -d
# install dependencies and setup db
mix setup
# load environment variables
export $(cat .env | xargs)
# start the server
mix phx.server
# or start with IEx
iex -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
