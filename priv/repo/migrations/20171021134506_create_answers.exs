defmodule Llp.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :attempts, :integer
      add :correct, :integer
      add :kanji_id, references(:kanji, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:kanji_id])
  end
end
