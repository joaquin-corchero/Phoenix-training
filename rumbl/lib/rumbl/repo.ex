defmodule Rumbl.Repo do
  @moduledoc """
  In memory repo
  """

  def all(Rumbl.User) do
    [%Rumbl.User{id: 1, name: "Pepe", username: "pepe.gotera", password: "password1"},
    %Rumbl.User{id: 2, name: "Antonio", username: "antonio.gotera", password: "password2"},
    %Rumbl.User{id: 3, name: "Juan", username: "juan.gotera", password: "password3"}]
  end

  def all(module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

end
