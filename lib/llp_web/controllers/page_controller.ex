defmodule LlpWeb.PageController do
  use LlpWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
