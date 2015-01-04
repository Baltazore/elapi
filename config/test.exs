use Mix.Config

config :elapi, Elapi.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
