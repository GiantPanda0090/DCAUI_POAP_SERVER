# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :poap_server, PoapServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3IL4XJUAL23ZP0HhdmOtT34LiraKk79e/3rZEiy8sxWOCB5x7thArql9SfGiHyXV",
  render_errors: [view: PoapServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PoapServer.PubSub,
  live_view: [signing_salt: "O/JCr3F1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
