defmodule FirstBucket.Admin.QuestionTest do
  use FirstBucket.ModelCase

  alias FirstBucket.Admin.Question

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Question.changeset(%Question{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Question.changeset(%Question{}, @invalid_attrs)
    refute changeset.valid?
  end
end
