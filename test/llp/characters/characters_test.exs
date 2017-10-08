defmodule Llp.CharactersTest do
  use Llp.DataCase

  alias Llp.Characters

  describe "radicals" do
    alias Llp.Characters.Radical

    @valid_attrs %{kunyomi: [], onyomi: [], radical: "some radical", stroke_count: 42}
    @update_attrs %{kunyomi: [], onyomi: [], radical: "some updated radical", stroke_count: 43}
    @invalid_attrs %{kunyomi: nil, onyomi: nil, radical: nil, stroke_count: nil}

    def radical_fixture(attrs \\ %{}) do
      {:ok, radical} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Characters.create_radical()

      radical
    end

    test "list_radicals/0 returns all radicals" do
      radical = radical_fixture()
      assert Characters.list_radicals() == [radical]
    end

    test "get_radical!/1 returns the radical with given id" do
      radical = radical_fixture()
      assert Characters.get_radical!(radical.id) == radical
    end

    test "create_radical/1 with valid data creates a radical" do
      assert {:ok, %Radical{} = radical} = Characters.create_radical(@valid_attrs)
      assert radical.kunyomi == []
      assert radical.onyomi == []
      assert radical.radical == "some radical"
      assert radical.stroke_count == 42
    end

    test "create_radical/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Characters.create_radical(@invalid_attrs)
    end

    test "update_radical/2 with valid data updates the radical" do
      radical = radical_fixture()
      assert {:ok, radical} = Characters.update_radical(radical, @update_attrs)
      assert %Radical{} = radical
      assert radical.kunyomi == []
      assert radical.onyomi == []
      assert radical.radical == "some updated radical"
      assert radical.stroke_count == 43
    end

    test "update_radical/2 with invalid data returns error changeset" do
      radical = radical_fixture()
      assert {:error, %Ecto.Changeset{}} = Characters.update_radical(radical, @invalid_attrs)
      assert radical == Characters.get_radical!(radical.id)
    end

    test "delete_radical/1 deletes the radical" do
      radical = radical_fixture()
      assert {:ok, %Radical{}} = Characters.delete_radical(radical)
      assert_raise Ecto.NoResultsError, fn -> Characters.get_radical!(radical.id) end
    end

    test "change_radical/1 returns a radical changeset" do
      radical = radical_fixture()
      assert %Ecto.Changeset{} = Characters.change_radical(radical)
    end
  end

  describe "kanji" do
    alias Llp.Characters.Kanji

    @valid_attrs %{kanji: "some kanji", kunyomi: [], meaning: [], onyomi: [], stroke_count: 42}
    @update_attrs %{kanji: "some updated kanji", kunyomi: [], meaning: [], onyomi: [], stroke_count: 43}
    @invalid_attrs %{kanji: nil, kunyomi: nil, meaning: nil, onyomi: nil, stroke_count: nil}

    def kanji_fixture(attrs \\ %{}) do
      {:ok, kanji} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Characters.create_kanji()

      kanji
    end

    test "list_kanji/0 returns all kanji" do
      kanji = kanji_fixture()
      assert Characters.list_kanji() == [kanji]
    end

    test "get_kanji!/1 returns the kanji with given id" do
      kanji = kanji_fixture()
      assert Characters.get_kanji!(kanji.id) == kanji
    end

    test "create_kanji/1 with valid data creates a kanji" do
      assert {:ok, %Kanji{} = kanji} = Characters.create_kanji(@valid_attrs)
      assert kanji.kanji == "some kanji"
      assert kanji.kunyomi == []
      assert kanji.meaning == []
      assert kanji.onyomi == []
      assert kanji.stroke_count == 42
    end

    test "create_kanji/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Characters.create_kanji(@invalid_attrs)
    end

    test "update_kanji/2 with valid data updates the kanji" do
      kanji = kanji_fixture()
      assert {:ok, kanji} = Characters.update_kanji(kanji, @update_attrs)
      assert %Kanji{} = kanji
      assert kanji.kanji == "some updated kanji"
      assert kanji.kunyomi == []
      assert kanji.meaning == []
      assert kanji.onyomi == []
      assert kanji.stroke_count == 43
    end

    test "update_kanji/2 with invalid data returns error changeset" do
      kanji = kanji_fixture()
      assert {:error, %Ecto.Changeset{}} = Characters.update_kanji(kanji, @invalid_attrs)
      assert kanji == Characters.get_kanji!(kanji.id)
    end

    test "delete_kanji/1 deletes the kanji" do
      kanji = kanji_fixture()
      assert {:ok, %Kanji{}} = Characters.delete_kanji(kanji)
      assert_raise Ecto.NoResultsError, fn -> Characters.get_kanji!(kanji.id) end
    end

    test "change_kanji/1 returns a kanji changeset" do
      kanji = kanji_fixture()
      assert %Ecto.Changeset{} = Characters.change_kanji(kanji)
    end
  end
end
