defmodule Llp.Characters.Kanji do
  use Ecto.Schema
  import Ecto.Changeset
  alias Llp.Characters.{Kanji, Radical}


  schema "kanji" do
    field :kanji, :string
    field :kunyomi, {:array, :string}
    field :meaning, {:array, :string}
    field :onyomi, {:array, :string}
    field :stroke_count, :integer

    belongs_to :radical, Radical

    timestamps()
  end

  @doc false
  def changeset(%Kanji{} = kanji, attrs) do
    kanji
    |> cast(attrs, [:kanji, :stroke_count, :onyomi, :kunyomi, :meaning])
    |> validate_required([:kanji, :stroke_count, :onyomi, :kunyomi, :meaning])
  end
end
