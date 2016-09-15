# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%Rumbl.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Rumbl.Repo
alias Rumbl.User
alias Rumbl.Category

Repo.insert!(%User{name: "Pepe", username: "pepe.gotera", password_hash: "password1"})
Repo.insert!(%User{name: "Antonio", username: "antonio.gotera", password_hash: "password2"})
Repo.insert!(%User{name: "Juan", username: "juan.gotera", password_hash: "password3"})

for(u <- Rumbl.Repo.all(User)) do
  Rumbl.Repo.update!(User.registration_changeset(u, %{password: u.password_hash || "temppass"}))
end

for category <- ~w(Action Drama Romance Comedy Sci-fi) do
  Repo.insert!(%Category{name: category})
end
