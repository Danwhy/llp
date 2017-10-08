defmodule Llp.Repo.Migrations.CreateKanji do
  use Ecto.Migration

  def change do
    create table(:kanji) do
      add :kanji, :string
      add :stroke_count, :integer
      add :onyomi, {:array, :string}
      add :kunyomi, {:array, :string}
      add :meaning, {:array, :string}
      add :radical_id, references(:radicals, on_delete: :nothing)

      timestamps()
    end

    create index(:kanji, [:radical_id])
  end
end
