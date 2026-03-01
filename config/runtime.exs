import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/slskx start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :slskx, SLSKXWeb.Endpoint, server: true
end

http_port = System.get_env("SLSKX_HTTP_PORT", "4080") |> String.to_integer()
https_port = System.get_env("SLSKX_HTTPS_PORT", "4443") |> String.to_integer()

config :slskx, SLSKXWeb.Endpoint,
  http: [port: http_port]

if config_env() == :prod do
  soulseek_username = System.get_env("SOULSEEK_USERNAME") || raise("environment variable SOULSEEK_USERNAME must be set.")
  soulseek_password = System.get_env("SOULSEEK_PASSWORD") || raise("environment variable SOULSEEK_PASSWORD must be set.")
  soulseek_server_host = System.get_env("SOULSEEK_SERVER_HOST", "vps.slsknet.org")
  soulseek_server_port = System.get_env("SOULSEEK_SERVER_PORT", "2271") |> String.to_integer()

  slskx_username = System.get_env("SLSKX_USERNAME")
  slskx_password = System.get_env("SLSKX_PASSWORD")
  shared_directories = System.get_env("SHARED_DIRECTORIES", "") |> String.split(",", trim: true)
  complete_directory = System.get_env("COMPLETE_DIRECTORY", "/downloads")
  incomplete_directory = System.get_env("INCOMPLETE_DIRECTORY", "/incomplete")

  config :slskx,
    soulseek_username: soulseek_username,
    soulseek_password: soulseek_password,
    soulseek_server_host: soulseek_server_host,
    soulseek_server_port: soulseek_server_port,
    share_directories: shared_directories,
    complete_directory: complete_directory,
    incomplete_directory: incomplete_directory,
    slskx_username: slskx_username,
    slskx_password: slskx_password

  database_username = System.get_env("DATABASE_USERNAME", "slskx")
  database_password = System.get_env("DATABASE_PASSWORD", "slskx")
  database_host = System.get_env("DATABASE_HOST", "postgres")
  database_port = System.get_env("DATABASE_PORT", "5432") |> String.to_integer()
  database_name = System.get_env("DATABASE_NAME", "slskx")
  database_pool_size = System.get_env("DATABASE_POOL_SIZE", "10") |> String.to_integer()

  database_url =
    System.get_env(
      "DATABASE_URL",
      "ecto://#{database_username}:#{database_password}@#{database_host}:#{database_port}/#{database_name}"
    )

  maybe_ipv6 = if System.get_env("DATABASE_IPV6") in ~w(true 1), do: [:inet6], else: []

  config :slskx, SLSKX.Repo,
    # ssl: true,
    url: database_url,
    pool_size: database_pool_size,
    # For machines with several cores, consider starting multiple pools of `pool_size`
    # pool_count: 4,
    socket_options: maybe_ipv6

  # used for node discovery for DNS based cluster discovery
  config :slskx, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  # The secret key base is used to sign/encrypt cookies and other secrets.
  secret_key_base =
    System.get_env("SLSKX_SECRET_KEY_BASE") ||
      raise """
      environment variable SLSKX_SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :slskx, SLSKXWeb.Endpoint,
    url: [
      host: System.get_env("SLSKX_HOSTNAME", "localhost"),
      port: System.get_env("HTTPS_LISTEN_PORT", "4443") |> String.to_integer(),
      scheme: "https"
    ],
    # See the documentation on https://hexdocs.pm/bandit/Bandit.html#t:options/0
    http: [ ip: :any ],
    https: [
      ip: :any,
      port: System.get_env("HTTPS_LISTEN_PORT", "4443") |> String.to_integer(),
      scheme: :https
    ],
    secret_key_base: secret_key_base

  # ## SSL Support
  #
  # To get SSL working, you will need to add the `https` key
  # to your endpoint configuration:
  #
  #     config :slskx, SLSKXWeb.Endpoint,
  #       https: [
  #         ...,
  #         port: 443,
  #         cipher_suite: :strong,
  #         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
  #         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
  #       ]
  #
  # The `cipher_suite` is set to `:strong` to support only the
  # latest and more secure SSL ciphers. This means old browsers
  # and clients may not be supported. You can set it to
  # `:compatible` for wider support.
  #
  # `:keyfile` and `:certfile` expect an absolute path to the key
  # and cert in disk or a relative path inside priv, for example
  # "priv/ssl/server.key". For all supported SSL configuration
  # options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
  #
  # We also recommend setting `force_ssl` in your config/prod.exs,
  # ensuring no data is ever sent via http, always redirecting to https:
  #
  #     config :slskx, SLSKXWeb.Endpoint,
  #       force_ssl: [hsts: true]
  #
  # Check `Plug.SSL` for all available options in `force_ssl`.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Here is an example configuration for Mailgun:
  #
  #     config :slskx, SLSKX.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # Most non-SMTP adapters require an API client. Swoosh supports Req, Hackney,
  # and Finch out-of-the-box. This configuration is typically done at
  # compile-time in your config/prod.exs:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Req
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
