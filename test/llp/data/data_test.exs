defmodule Llp.DataTest do
  use Llp.DataCase

  alias Llp.Data

  describe "answers" do
    alias Llp.Data.Answer

    @valid_attrs %{attempts: 42, correct: 42}
    @update_attrs %{attempts: 43, correct: 43}
    @invalid_attrs %{attempts: nil, correct: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Data.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Data.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = Data.create_answer(@valid_attrs)
      assert answer.attempts == 42
      assert answer.correct == 42
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, answer} = Data.update_answer(answer, @update_attrs)
      assert %Answer{} = answer
      assert answer.attempts == 43
      assert answer.correct == 43
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_answer(answer, @invalid_attrs)
      assert answer == Data.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Data.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Data.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Data.change_answer(answer)
    end
  end
end
