defmodule FirstBucket.Admin.AnswerController do
  use FirstBucket.Web, :controller

  alias FirstBucket.Admin.Answer
  alias FirstBucket.Admin.Question

  plug :scrub_params, "answer" when action in [:create, :update]

  def index(conn, %{"question_id" => question_id}) do
    question = Question |> Repo.get!(question_id) |> Repo.preload [:answers]
    render(conn, "index.html", question: question, answers: question.answers)
  end

  def new(conn, %{"question_id" => question_id}) do
    changeset = Answer.changeset(%Answer{}) 
    render(conn, "new.html", question_id: question_id, changeset: changeset)
  end

  def create(conn, %{"question_id" => question_id, "answer" => answer_params}) do
    changeset = Answer.changeset(%Answer{}, answer_params)
    changeset = Ecto.Changeset.put_change(changeset, :question_id, String.to_integer(question_id) )

    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: admin_question_answer_path(conn, :index, question_id))
      {:error, changeset} ->
        render(conn, "new.html", question_id: question_id, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Repo.get!(Answer, id)
    render(conn, "show.html", answer: answer)
  end

  def edit(conn, %{"id" => id}) do
    answer = Repo.get!(Answer, id)
    changeset = Answer.changeset(answer)
    render(conn, "edit.html", answer: answer, changeset: changeset)
  end

  def update(conn, %{"question_id" => question_id, "id" => id, "answer" => answer_params}) do
    answer = Repo.get!(Answer, id)
    changeset = Answer.changeset(answer, answer_params)

    case Repo.update(changeset) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: admin_question_answer_path(conn, :show, question_id, answer))
      {:error, changeset} ->
        render(conn, "edit.html", answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"question_id" => question_id, "id" => id}) do
    answer = Repo.get!(Answer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: admin_question_answer_path(conn, :index, question_id))
  end
end
