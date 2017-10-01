defmodule LlpWeb.RadicalController do
  use LlpWeb, :controller

  alias Llp.Characters
  alias Llp.Characters.Radical

  def index(conn, _params) do
    radicals = Characters.list_radicals()
    render(conn, "index.html", radicals: radicals)
  end

  def new(conn, _params) do
    changeset = Characters.change_radical(%Radical{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"radical" => radical_params}) do
    case Characters.create_radical(radical_params) do
      {:ok, radical} ->
        conn
        |> put_flash(:info, "Radical created successfully.")
        |> redirect(to: radical_path(conn, :show, radical))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    radical = Characters.get_radical!(id)
    render(conn, "show.html", radical: radical)
  end

  def edit(conn, %{"id" => id}) do
    radical = Characters.get_radical!(id)
    changeset = Characters.change_radical(radical)
    render(conn, "edit.html", radical: radical, changeset: changeset)
  end

  def update(conn, %{"id" => id, "radical" => radical_params}) do
    radical = Characters.get_radical!(id)

    case Characters.update_radical(radical, radical_params) do
      {:ok, radical} ->
        conn
        |> put_flash(:info, "Radical updated successfully.")
        |> redirect(to: radical_path(conn, :show, radical))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", radical: radical, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    radical = Characters.get_radical!(id)
    {:ok, _radical} = Characters.delete_radical(radical)

    conn
    |> put_flash(:info, "Radical deleted successfully.")
    |> redirect(to: radical_path(conn, :index))
  end
end
