defmodule FirstBucket.Admin.Answer do
  use FirstBucket.Web, :model

  schema "answers" do
    field :content, :string
    field :is_correct, :boolean, default: false
    belongs_to :question, FirstBucket.Admin.Question

    timestamps
  end

  @required_fields ~w(content is_correct)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:question_id)
  end
end
