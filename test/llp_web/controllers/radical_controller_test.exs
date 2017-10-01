defmodule LlpWeb.RadicalControllerTest do
  use LlpWeb.ConnCase

  alias Llp.Characters

  @create_attrs %{kunyomi: [], onyomi: [], radical: "some radical", stroke_count: 42}
  @update_attrs %{kunyomi: [], onyomi: [], radical: "some updated radical", stroke_count: 43}
  @invalid_attrs %{kunyomi: nil, onyomi: nil, radical: nil, stroke_count: nil}

  def fixture(:radical) do
    {:ok, radical} = Characters.create_radical(@create_attrs)
    radical
  end

  describe "index" do
    test "lists all radicals", %{conn: conn} do
      conn = get conn, radical_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Radicals"
    end
  end

  describe "new radical" do
    test "renders form", %{conn: conn} do
      conn = get conn, radical_path(conn, :new)
      assert html_response(conn, 200) =~ "New Radical"
    end
  end

  describe "create radical" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, radical_path(conn, :create), radical: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == radical_path(conn, :show, id)

      conn = get conn, radical_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Radical"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, radical_path(conn, :create), radical: @invalid_attrs
      assert html_response(conn, 200) =~ "New Radical"
    end
  end

  describe "edit radical" do
    setup [:create_radical]

    test "renders form for editing chosen radical", %{conn: conn, radical: radical} do
      conn = get conn, radical_path(conn, :edit, radical)
      assert html_response(conn, 200) =~ "Edit Radical"
    end
  end

  describe "update radical" do
    setup [:create_radical]

    test "redirects when data is valid", %{conn: conn, radical: radical} do
      conn = put conn, radical_path(conn, :update, radical), radical: @update_attrs
      assert redirected_to(conn) == radical_path(conn, :show, radical)

      conn = get conn, radical_path(conn, :show, radical)
      assert html_response(conn, 200) =~ ""
    end

    test "renders errors when data is invalid", %{conn: conn, radical: radical} do
      conn = put conn, radical_path(conn, :update, radical), radical: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Radical"
    end
  end

  describe "delete radical" do
    setup [:create_radical]

    test "deletes chosen radical", %{conn: conn, radical: radical} do
      conn = delete conn, radical_path(conn, :delete, radical)
      assert redirected_to(conn) == radical_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, radical_path(conn, :show, radical)
      end
    end
  end

  defp create_radical(_) do
    radical = fixture(:radical)
    {:ok, radical: radical}
  end
end
