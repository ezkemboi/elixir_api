# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirApi.Repo.insert!(%ElixirApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ElixirApi.Repo 
alias ElixirApi.Directory.Business
Repo.insert! %Business{name: "Semabu", description: "Dealing with classified marketing", tag: "marketing"}
Repo.insert! %Business{name: "Andela", description: "Offering engineering as a service", tag: "engineering"}
