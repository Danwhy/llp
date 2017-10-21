defmodule Llp.Data.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Llp.Data.Answer


  schema "answers" do
    field :attempts, :integer
    field :correct, :integer

    belongs_to :kanji, Kanji

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:attempts, :correct])
    |> validate_required([:attempts, :correct])
  end
end
