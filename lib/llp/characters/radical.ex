defmodule Llp.Characters.Radical do
  use Ecto.Schema
  import Ecto.Changeset
  alias Llp.Characters.{Radical, Kanji}


  schema "radicals" do
    field :kunyomi, {:array, :string}
    field :onyomi, {:array, :string}
    field :radical, :string
    field :stroke_count, :integer

    has_many :kanji, Kanji

    timestamps()
  end

  @doc false
  def changeset(%Radical{} = radical, attrs) do
    radical
    |> cast(attrs, [:radical, :stroke_count, :onyomi, :kunyomi])
    |> validate_required([:radical, :stroke_count, :onyomi, :kunyomi])
  end
end
