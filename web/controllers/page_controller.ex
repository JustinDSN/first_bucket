defmodule FirstBucket.PageController do
  use FirstBucket.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
