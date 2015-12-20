defmodule Server.User do
  use Server.Web, :model

  @doc """
   You probably created the user with mix.phoenix.gen.html Parameters...
   that create alot templates that aren't used on a pure api end
   Hence don't be alarmed for the lacking of api to creating users and whatnot templates html
   Most of Phoenix tutorials cover that perfectly
   this is a pure api end for login to learning porpuse that simply spit a JWT once the login is done
   I choose to clean the templates and not the hello world stuff 'cause 
   i got really confused about the integration at the beginning and a cleaner
   folder helped me to see the data-flow in my head better 
   """

  schema "users" do
    field :login, :string
    field :password, :string
    # no encrypted password is done
    # for this i should have used virtual variable for the password
    # and store the encrypted one in the database

    timestamps
  end

  @required_fields ~w(login password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    # Now we should validate the changes but i choose to ignore this
  end

  # here is the password check function
  # to validate it return a tuple with :ok and the model : {:ok, model}
  # to invalidate return a tuple {:error, reason}
  # reason can be anything it is simply for debuggin or rendering purposes
  def check_password(model, params) do
    {:ok, model}
  end  
end
