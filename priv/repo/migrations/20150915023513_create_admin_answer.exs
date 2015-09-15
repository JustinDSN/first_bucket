defmodule FirstBucket.Repo.Migrations.CreateAdmin.Answer do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :content, :text
      add :is_correct, :boolean, default: false
      add :question_id, references(:questions)

      timestamps
    end
    create index(:answers, [:question_id])

  end
end
