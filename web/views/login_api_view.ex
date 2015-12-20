defmodule Server.Api.LoginView do
  use Server.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Server.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Server.UserView, "user.json")}
  end

  # The render functions will call the first render on index.json
  # then call the render on show to finally call render on user.json
  # then we do a simply evaluation to check if the user we are receiving was found
  # if not we output the error JSON
  def render("user.json", %{user: user, jwt: jwt}) do
    if user != nil do
      %{id: user.id,
    	  jwt: jwt}
    else
      %{reason: "Login Error", error: "true"}
    end

  end

end
