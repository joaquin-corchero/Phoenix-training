defmodule Rumbl.Repo do
  use Ecto.Repo, otp_app: :rumbl

#To seed the db from console:
#iex -S mix
#alias Rumbl.Repo
#alias Rumbl.User
#Repo.insert(%User{name: "Pepe", username: "pepe.gotera", pasword_hash: "password1"})
#Repo.insert(%User{name: "Antonio", username: "antonio.gotera", pasword_hash: "password2"})
#Repo.insert(%User{name: "Juan", username: "juan.gotera", pasword_hash: "password3"})
  
end
