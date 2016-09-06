defmodule Rumbl.User do
  use Rumbl.Web, :model
  #to create the migration you need to execute 
  #mix phoenix.gen.html User users name:string username:string pasword_hash:string
  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :pasword_hash])
    |> validate_required([:name, :username, :pasword_hash])
  end
end
