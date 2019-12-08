defmodule MutWeb.PageController do
  use MutWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
