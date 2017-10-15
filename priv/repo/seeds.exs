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
alias Llp.Characters
alias Llp.Characters.{Radical, Kanji}

defmodule Llp.CharacterSeed do
  def add_radical([_id, radical, stroke_count, onyomi, kunyomi, _meaning]) do
    %Radical{}
      |> Radical.changeset(
        %{
          "radical" => radical, "stroke_count" => stroke_count,
          "onyomi" => String.split(onyomi, ","),
          "kunyomi" => String.split(kunyomi, ",")
        }
      )
      |> Repo.insert!()
  end

  def add_kanji([_id, kanji, stroke_count, onyomi, kunyomi, meaning, radical]) do
    radical
      |> Characters.get_radical_by_character!
      |> Ecto.build_assoc(:kanji)
      |> Kanji.changeset(
        %{
          "kanji" => kanji, "stroke_count" => stroke_count,
          "onyomi" => String.split(onyomi, ","),
          "kunyomi" => String.split(kunyomi, ","),
          "meaning" => String.split(meaning, ",")
        }
      )
      |> Repo.insert!()
  end
end

[
  {"radicals", &Llp.CharacterSeed.add_radical/1},
  {"kanji", &Llp.CharacterSeed.add_kanji/1}
]
  |> Enum.each(fn {str, fun} ->
    "#{File.cwd!}/#{str}.csv"
      |> File.read!
      |> CSV.parse_string
      |> Enum.each(fun)
  end)
