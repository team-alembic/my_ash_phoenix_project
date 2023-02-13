defmodule MyAshPhoenixAppWeb.PageController do
  use MyAshPhoenixAppWeb, :controller

  def index(conn, _params) do
    conn
    |> assign(:posts, MyAshPhoenixApp.Blog.read!(MyAshPhoenixApp.Blog.Post))
    |> render("index.html")
  end
end
