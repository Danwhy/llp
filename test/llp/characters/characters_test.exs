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
end
