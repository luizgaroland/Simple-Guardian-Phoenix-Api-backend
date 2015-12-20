defmodule Server.Api.LoginController do
  use Server.Web, :controller
  use Guardian.Phoenix.Controller

  alias Server.User
  alias Server.Repo

  # Api login function the very soul of the this simply api
  def login(conn, params, _user, _claims) do    
    # first we get the user with the params provided
    user = get_user(conn, params["login"])

    # Now we check the password 
    case User.check_password(user, params["password"]) do
      # as the case states
      # if we get a tuple with {:ok, user} 
      {:ok, user} ->
        # conn gonna rceive a sign in on api pipeline with the specified model
        conn = Guardian.Plug.api_sign_in(conn, user, :api)
        # then we get the token from the current session
        jwt = Guardian.Plug.current_token(conn)

        # now we put the auth Header with the token on the connection
        # and call the View render with the model and the JWT 
        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> render("user.json", user: user, jwt: jwt)
        
      {:error, reason} ->
        # like get_user error below we simply use render to show the error
        # reason could be used to pass something to the render or debbuging porpuses
        conn
        |> put_status(401)
        |> render("user.json", user: nil, jwt: nil)
    end

  end # login func   

  defp get_user(conn, login) do
    # user = Repo.get_by(User, login: params["login"])
    # we try to get a user by the given login
    # we arent checking if the user exists so if we insert a non-existant
    # login it will give an Error at the view cause is trying to render nil.id
    # alternativaly we could use Repo.get_by! to raise the EctoNoResultsError
    # and then treat it
    user = Repo.get_by(User, login: login)
    if user == nil do
        IO.puts "nil case"
        conn
        |> put_status(401)
        |> render("user.json", user: nil, jwt: nil)
      else
        user
    end

  end # get_user

end # module 