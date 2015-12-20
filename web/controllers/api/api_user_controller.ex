
defmodule Server.Api.UserController do
  use Server.Web, :controller
  use Guardian.Phoenix.Controller

  alias Server.User
  alias Guardian.Plug.EnsureAuthenticated
  alias Guardian.Plug.EnsurePermissions

  plug EnsureAuthenticated, handler: __MODULE__
  plug EnsurePermissions, handler: __MODULE__, default: [:write_profile]

  def index(conn, _params, current_user, _claims) do
    users = Repo.all(User)
    json(conn, %{ data: users, current_user: current_user })
  end


  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render("unauthenticated.json")
  end

  def unauthorized(conn, _params) do
    IO.puts "unauthorized"
  end
end