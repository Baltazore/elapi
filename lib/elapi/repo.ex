defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://postgres:postgres@localhost/elapi"
  end

  def priv do
    app_dir(:elapi, "priv/repo")
  end
end
