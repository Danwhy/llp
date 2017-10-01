defmodule Llp.Repo.Migrations.CreateRadicals do
  use Ecto.Migration

  def change do
    create table(:radicals) do
      add :radical, :string
      add :stroke_count, :integer
      add :onyomi, {:array, :string}
      add :kunyomi, {:array, :string}

      timestamps()
    end

  end
end
