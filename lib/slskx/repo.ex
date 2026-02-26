defmodule SLSKX.Repo do
  use Ecto.Repo,
    otp_app: :slskx,
    adapter: Ecto.Adapters.Postgres
end
