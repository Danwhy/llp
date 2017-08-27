use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :llp, LlpWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :llp, Llp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "llp_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
