defmodule MyAshPhoenixApp.Blog do
  use Ash.Api

  resources do
    registry MyAshPhoenixApp.Blog.Registry
  end
end
