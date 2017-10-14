defmodule LlpWeb.KanjiController do
  use LlpWeb, :controller

  alias Llp.Characters
  alias Llp.Characters.Kanji

  def index(conn, _params) do
    kanji = Characters.list_kanji()
    render(conn, "index.html", kanji: kanji)
  end

  def new(conn, _params) do
    changeset = Characters.change_kanji(%Kanji{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kanji" => kanji_params}) do
    character = kanji_params["radical_character"]
    radical = Characters.get_radical_by_character!(character)

    case Characters.create_kanji(
      radical,
      kanji_params
      |> Map.merge(%{"radical" => kanji_params["radical_character"]})
      |> Map.delete("radical_character")
    ) do
      {:ok, kanji} ->
        conn
        |> put_flash(:info, "Kanji created successfully.")
        |> redirect(to: kanji_path(conn, :show, kanji))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kanji = Characters.get_kanji!(id)
    render(conn, "show.html", kanji: kanji)
  end

  def edit(conn, %{"id" => id}) do
    kanji = Characters.get_kanji!(id)
    changeset = Characters.change_kanji(kanji)
    render(conn, "edit.html", kanji: kanji, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kanji" => kanji_params}) do
    kanji = Characters.get_kanji!(id)

    case Characters.update_kanji(kanji, kanji_params) do
      {:ok, kanji} ->
        conn
        |> put_flash(:info, "Kanji updated successfully.")
        |> redirect(to: kanji_path(conn, :show, kanji))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", kanji: kanji, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kanji = Characters.get_kanji!(id)
    {:ok, _kanji} = Characters.delete_kanji(kanji)

    conn
    |> put_flash(:info, "Kanji deleted successfully.")
    |> redirect(to: kanji_path(conn, :index))
  end
end
