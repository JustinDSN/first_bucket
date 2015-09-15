defmodule FirstBucket.Admin.AnswerTest do
  use FirstBucket.ModelCase

  alias FirstBucket.Admin.Answer

  @valid_attrs %{content: "some content", is_correct: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Answer.changeset(%Answer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Answer.changeset(%Answer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
