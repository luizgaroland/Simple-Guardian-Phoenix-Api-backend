defmodule Server.Router do
  use Server.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # We now have updated the pipeline :api to verify the auth header for a JWT
  # calling it the Bearer
  # then it load its resources
  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end


  scope "/api", Server.Api do
    pipe_through [:api]

    post "/apilogin", LoginController, :login

  end

  # Other scopes may use custom stacks.
  # scope "/api", Server do
  #   pipe_through :api
  # end
end
