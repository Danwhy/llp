# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Llp.Repo.insert!(%Llp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NimbleCSV.RFC4180, as: CSV
alias Llp.Repo
alias Llp.Characters.Radical

"#{File.cwd!}/radicals.csv"
|> File.read!
|> CSV.parse_string
|> Enum.each(fn [id, radical, stroke_count, onyomi, kunyomi, meaning] ->
  %Radical{}
  |> Radical.changeset(
    %{
      "radical" => radical, "stroke_count" => stroke_count,
      "onyomi" => String.split(onyomi, ","),
      "kunyomi" => String.split(kunyomi, ",")
    }
  )
  |> Repo.insert!()
end)
