defmodule Elapi.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Elapi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Elapi do
  #   pipe_through :api
  # end
end
