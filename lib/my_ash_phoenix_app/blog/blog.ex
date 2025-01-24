defmodule MyAshPhoenixApp.Blog do
  use Ash.Domain

  resources do
    resource MyAshPhoenixApp.Blog.Post do
      # Define an interface for calling resource actions.
      define :create_post, action: :create
      define :list_posts, action: :read
      define :destroy_post, action: :destroy
      define :get_post, args: [:id], action: :by_id
    end
  end
end
