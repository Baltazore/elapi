defmodule Elapi.UserController do
  use Phoenix.Controller
  require IEx

  alias Phoenix.Controller.Flash
  alias Elapi.Router
  alias Elapi.User

  plug :action

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      user when is_map(user) ->
        render conn, "show.html", user: user
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => %{"name" => name}}) do
    user = %User{name: name}

    case User.validate(user) do
      :nil ->
        user = Repo.insert(user)
        conn
        |> Flash.put(:notice, "User successfully created!")
        |> render "show.html", user: user
      errors ->
        conn
        |> Flash.put(:error, errors)
        |> render "show.html", user: user, errors: errors
    end
  end

  def edit(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      user when is_map(user) ->
        render conn, "edit.html", user: user
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, id)
    user = %{user | name: params["name"]}

    case User.validate(user) do
      :nil ->
        Repo.update(user)
        # really hacky way to redirect in the client.. (is there a better way?)
        conn
        |> Flash.put(:notice, "User successfully updated!")
        |> render "show.html", user: user
      errors ->
        conn
        |> Flash.put(:error, "There are few errors.")
        |> render "edit.html", user: user, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    case user do
      user when is_map(user) ->
        Repo.delete(user)
        conn
        |> Flash.put(:notice, "User successfully deleted!")
        |> render "index.html", users: Repo.all(User)

      _ ->
        conn
        |> Flash.put(:error, "User cannot be deleted.")
        |> redirect Router.page_path(page: "unauthorized")
    end
  end

end
