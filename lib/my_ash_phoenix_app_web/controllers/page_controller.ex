defmodule MyAshPhoenixAppWeb.PageController do
  use MyAshPhoenixAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
