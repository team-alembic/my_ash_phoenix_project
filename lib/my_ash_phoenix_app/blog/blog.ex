defmodule MyAshPhoenixApp.Blog do
  use Ash.Domain

  resources do
    resource MyAshPhoenixApp.Blog.Post
  end
end
