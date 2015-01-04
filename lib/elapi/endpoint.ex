defmodule Elapi.Endpoint do
  use Phoenix.Endpoint, otp_app: :elapi

  plug Plug.Static,
    at: "/", from: :elapi

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elapi_key",
    signing_salt: "d2tKr9ZT",
    encryption_salt: "DF0fcsAO"

  plug :router, Elapi.Router
end
