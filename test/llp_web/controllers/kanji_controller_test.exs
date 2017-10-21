defmodule LlpWeb.KanjiControllerTest do
  use LlpWeb.ConnCase

  alias Llp.Characters
  alias LlpWeb.RadicalControllerTest

  @create_attrs %{kanji: "some kanji", kunyomi: [], meaning: [], onyomi: [], stroke_count: 42}
  @update_attrs %{kanji: "some updated kanji", kunyomi: [], meaning: [], onyomi: [], stroke_count: 43}
  @invalid_attrs %{kanji: nil, kunyomi: nil, meaning: nil, onyomi: nil, stroke_count: nil}

  def fixture(:kanji) do
    radical = RadicalControllerTest.fixture(:radical)
    {:ok, kanji} = Characters.create_kanji(radical, @create_attrs)
    kanji
  end

  describe "index" do
    test "lists all kanji", %{conn: conn} do
      conn = get conn, kanji_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Kanji"
    end
  end

  describe "new kanji" do
    test "renders form", %{conn: conn} do
      conn = get conn, kanji_path(conn, :new)
      assert html_response(conn, 200) =~ "New Kanji"
    end
  end

  describe "create kanji" do
    test "redirects to show when data is valid", %{conn: conn} do
      radical = RadicalControllerTest.fixture(:radical)
      kanji_attrs = Map.put_new(@create_attrs, :radical_character, radical.radical)
      conn = post conn, kanji_path(conn, :create), kanji: kanji_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == kanji_path(conn, :show, id)

      conn = get conn, kanji_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Kanji"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      radical = RadicalControllerTest.fixture(:radical)
      kanji_attrs = Map.put_new(@invalid_attrs, :radical_character, radical.radical)
      conn = post conn, kanji_path(conn, :create), kanji: kanji_attrs
      assert html_response(conn, 200) =~ "New Kanji"
    end
  end

  describe "edit kanji" do
    setup [:create_kanji]

    test "renders form for editing chosen kanji", %{conn: conn, kanji: kanji} do
      conn = get conn, kanji_path(conn, :edit, kanji)
      assert html_response(conn, 200) =~ "Edit Kanji"
    end
  end

  describe "update kanji" do
    setup [:create_kanji]

    test "redirects when data is valid", %{conn: conn, kanji: kanji} do
      conn = put conn, kanji_path(conn, :update, kanji), kanji: @update_attrs
      assert redirected_to(conn) == kanji_path(conn, :show, kanji)

      conn = get conn, kanji_path(conn, :show, kanji)
      assert html_response(conn, 200) =~ "some updated kanji"
    end

    test "renders errors when data is invalid", %{conn: conn, kanji: kanji} do
      conn = put conn, kanji_path(conn, :update, kanji), kanji: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Kanji"
    end
  end

  describe "delete kanji" do
    setup [:create_kanji]

    test "deletes chosen kanji", %{conn: conn, kanji: kanji} do
      conn = delete conn, kanji_path(conn, :delete, kanji)
      assert redirected_to(conn) == kanji_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, kanji_path(conn, :show, kanji)
      end
    end
  end

  defp create_kanji(_) do
    kanji = fixture(:kanji)
    {:ok, kanji: kanji}
  end
end
