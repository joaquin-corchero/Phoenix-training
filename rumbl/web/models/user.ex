defmodule Rumbl.User do
  use Rumbl.Web, :model
  #to create the migration you need to execute
  #mix phoenix.gen.html User users name:string username:string pasword_hash:string
  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name username), []) #both fields are required
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), []) #both fields are required
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
       %Ecto.Changeset{valid?: true, changes: %{password: pass} } ->
         put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
         _ ->
         changeset
    end
  end
end
