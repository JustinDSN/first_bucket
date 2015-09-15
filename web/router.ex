defmodule FirstBucket.Router do
  use FirstBucket.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FirstBucket do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/admin", FirstBucket.Admin, as: :admin do
    pipe_through :browser

    resources "/questions", QuestionController do
      resources "/answers", AnswerController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstBucket do
  #   pipe_through :api
  # end

  defimpl Plug.Exception, for: Ecto.NoResultsError do
    def status(_exception), do: 404
  end
end
