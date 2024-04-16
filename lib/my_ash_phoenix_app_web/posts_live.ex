defmodule MyAshPhoenixAppWeb.PostsLive do
  use MyAshPhoenixAppWeb, :live_view
  alias MyAshPhoenixApp.Blog.Post

  def render(assigns) do
    ~H"""
    <h2>Posts</h2>
    <div>
      <%= for post <- @posts do %>
        <div>
          <div><%= post.title %></div>
          <div><%= if Map.get(post, :content), do: post.content, else: "" %></div>
          <button phx-click="delete_post" phx-value-post-id={post.id}>delete</button>
        </div>
      <% end %>
    </div>
    <h2>Create Post</h2>
    <.form :let={f} for={@create_form} phx-submit="create_post">
      <.input type="text" field={f[:title]} placeholder="input title" />
      <.button type="submit">create</.button>
    </.form>
    <h2>Update Post</h2>
    <.form :let={f} for={@update_form} phx-submit="update_post">
      <.label>Post Name</.label>
      <.input type="select" field={f[:post_id]} options={@post_selector} />
      <.input type="text" field={f[:content]} placeholder="input content" />
      <.button type="submit">Update</.button>
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    posts = Post.read_all!()

    socket =
      assign(socket,
        posts: posts,
        post_selector: post_selector(posts),
        # the `to_form/1` calls below are for liveview 0.18.12+. For earlier versions, remove those calls
        create_form: AshPhoenix.Form.for_create(Post, :create) |> to_form(),
        update_form: AshPhoenix.Form.for_update(List.first(posts, %Post{}), :update) |> to_form()
      )

    {:ok, socket}
  end

  def handle_event("delete_post", %{"post-id" => post_id}, socket) do
    post_id |> Post.get_by_id!() |> Post.destroy!()
    posts = Post.read_all!()

    {:noreply, assign(socket, posts: posts, post_selector: post_selector(posts))}
  end

  def handle_event("create_post", %{"form" => %{"title" => title}}, socket) do
    Post.create(%{title: title})
    posts = Post.read_all!()

    {:noreply, assign(socket, posts: posts, post_selector: post_selector(posts))}
  end

  def handle_event("update_post", %{"form" => form_params}, socket) do
    %{"post_id" => post_id, "content" => content} = form_params

    post_id |> Post.get_by_id!() |> Post.update!(%{content: content})
    posts = Post.read_all!()

    {:noreply, assign(socket, posts: posts, post_selector: post_selector(posts))}
  end

  defp post_selector(posts) do
    for post <- posts do
      {post.title, post.id}
    end
  end
end
