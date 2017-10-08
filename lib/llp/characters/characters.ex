defmodule Llp.Characters do
  @moduledoc """
  The Characters context.
  """

  import Ecto.Query, warn: false
  alias Llp.Repo

  alias Llp.Characters.Radical

  @doc """
  Returns the list of radicals.

  ## Examples

      iex> list_radicals()
      [%Radical{}, ...]

  """
  def list_radicals do
    Repo.all(Radical)
  end

  @doc """
  Gets a single radical.

  Raises `Ecto.NoResultsError` if the Radical does not exist.

  ## Examples

      iex> get_radical!(123)
      %Radical{}

      iex> get_radical!(456)
      ** (Ecto.NoResultsError)

  """
  def get_radical!(id), do: Repo.get!(Radical, id)

  @doc """
  Creates a radical.

  ## Examples

      iex> create_radical(%{field: value})
      {:ok, %Radical{}}

      iex> create_radical(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_radical(attrs \\ %{}) do
    %Radical{}
    |> Radical.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a radical.

  ## Examples

      iex> update_radical(radical, %{field: new_value})
      {:ok, %Radical{}}

      iex> update_radical(radical, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_radical(%Radical{} = radical, attrs) do
    radical
    |> Radical.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Radical.

  ## Examples

      iex> delete_radical(radical)
      {:ok, %Radical{}}

      iex> delete_radical(radical)
      {:error, %Ecto.Changeset{}}

  """
  def delete_radical(%Radical{} = radical) do
    Repo.delete(radical)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking radical changes.

  ## Examples

      iex> change_radical(radical)
      %Ecto.Changeset{source: %Radical{}}

  """
  def change_radical(%Radical{} = radical) do
    Radical.changeset(radical, %{})
  end

  alias Llp.Characters.Kanji

  @doc """
  Returns the list of kanji.

  ## Examples

      iex> list_kanji()
      [%Kanji{}, ...]

  """
  def list_kanji do
    Repo.all(Kanji)
  end

  @doc """
  Gets a single kanji.

  Raises `Ecto.NoResultsError` if the Kanji does not exist.

  ## Examples

      iex> get_kanji!(123)
      %Kanji{}

      iex> get_kanji!(456)
      ** (Ecto.NoResultsError)

  """
  def get_kanji!(id), do: Repo.get!(Kanji, id)

  @doc """
  Creates a kanji.

  ## Examples

      iex> create_kanji(%{field: value})
      {:ok, %Kanji{}}

      iex> create_kanji(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_kanji(radical, attrs \\ %{}) do
    radical
    |> Ecto.build_assoc(:kanji)
    |> Kanji.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a kanji.

  ## Examples

      iex> update_kanji(kanji, %{field: new_value})
      {:ok, %Kanji{}}

      iex> update_kanji(kanji, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_kanji(%Kanji{} = kanji, attrs) do
    kanji
    |> Kanji.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Kanji.

  ## Examples

      iex> delete_kanji(kanji)
      {:ok, %Kanji{}}

      iex> delete_kanji(kanji)
      {:error, %Ecto.Changeset{}}

  """
  def delete_kanji(%Kanji{} = kanji) do
    Repo.delete(kanji)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking kanji changes.

  ## Examples

      iex> change_kanji(kanji)
      %Ecto.Changeset{source: %Kanji{}}

  """
  def change_kanji(%Kanji{} = kanji) do
    Kanji.changeset(kanji, %{})
  end
end
