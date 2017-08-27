# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :llp,
  ecto_repos: [Llp.Repo]

# Configures the endpoint
config :llp, LlpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y5s9N7aPYek+t16BkKq693knrKBBaOyU2DLPOicWZXVlqA6zRfyR1BDtsmaPhz7P",
  render_errors: [view: LlpWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Llp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
