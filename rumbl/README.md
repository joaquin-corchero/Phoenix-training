# Rumbl

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
## Learn more


  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

##create migration for db
* mix phoenix.gen.html User users name:string username:string pasword_hash:string

##phoenix commands:
* mix phoenix.server: runs the app
* mix phoenix.routes: allows to see the routes for the project

##ecto commands
* mix ecto.create database_name -creates a database
* mix ecto.gen.migration name_of_migration -> after doing changes to models to create the migration
* mix ecto.migrate -> execute migrations not executed already
* mix phoenix.gen.model Category categories name:string -> generates model
* mix run priv/repo/seeds.exs -> execute seeding
