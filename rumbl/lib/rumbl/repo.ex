defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl

  def all(Rumbl.User) do
    #[%Rumbl.User{id: "1", name: "Pepe", username: "pepe.gotera", password: "password1"},
    #%Rumbl.User{id: "2", name: "Antonio", username: "antonio.gotera", password: "password2"},
    #%Rumbl.User{id: "3", name: "Juan", username: "juan.gotera", password: "password3"}]
  
end
