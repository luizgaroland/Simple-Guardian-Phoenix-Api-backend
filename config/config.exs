# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :server, Server.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "GaZI5Pal8R8sou9VPcwQap+ERmgxad+c8w0fx56CQKJ8MSe0k9pFriwy+3cos0Nu",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Server.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Guardian configuration
# Mostly default stuff
# the serializer that i use goes into (AppFolder)/lib/server
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Server",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  # This is your secret key you can put whatever you like
  secret_key: "Breno_Magro",
  serializer: Server.GuardianSerializer