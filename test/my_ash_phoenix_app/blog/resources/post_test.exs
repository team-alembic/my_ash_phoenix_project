defmodule MyAshPhoenixApp.Blog.PostTest do
  use MyAshPhoenixApp.DataCase, async: true

  test "testing blog post actions" do
    ### CREATE ACTION - create new blog post ###
    # We create an Ash changeset we intent to use to create an Ash resource
    create_post_changeset =
      Ash.Changeset.for_create(
        # We specify which resource we want to create a changeset for
        MyAshPhoenixApp.Blog.Post,
        # We name the specific create action
        :create,
        # We pass the attributes we want to initialise our resource with
        %{title: "hello world"}
      )

    # will return:
    #
    # #Ash.Changeset<
    #   action_type: :create,
    #   action: :create,
    #   attributes: %{title: "hello world"},
    #   relationships: %{},
    #   errors: [],
    #   data: #MyAshPhoenixApp.Blog.Post<
    #     __meta__: #Ecto.Schema.Metadata<:built, "posts">,
    #     id: nil,
    #     title: nil,
    #     content: nil,
    #     aggregates: %{},
    #     calculations: %{},
    #     __order__: nil,
    #     ...
    #   >,
    #   valid?: true
    # >

    # This changeset is given to the Ash Api the resource belongs to.
    # The Api then tries to create the resource specified in the changeset.
    assert %{title: "hello world"} = MyAshPhoenixApp.Blog.create!(create_post_changeset)
    # will return:
    #
    # #MyAshPhoenixApp.Blog.Post<
    #   __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
    #   id: "d70dd979-0b30-4a3f-beb2-2d5bb2e24af7",
    #   title: "hello world",
    #   content: nil,
    #   aggregates: %{},
    #   calculations: %{},
    #   __order__: nil,
    #   ...
    # >

    ### READ ACTION - read blog post(s) ###
    assert [first_post = %{title: "hello world"}] =
             MyAshPhoenixApp.Blog.Post
             |> Ash.Query.for_read(:read)
             |> MyAshPhoenixApp.Blog.read!()

    # will return:
    #
    # [
    #   #MyAshPhoenixApp.Blog.Post<
    #     __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
    #     id: "d70dd979-0b30-4a3f-beb2-2d5bb2e24af7",
    #     title: "hello world",
    #     content: nil,
    #     aggregates: %{},
    #     calculations: %{},
    #     __order__: nil,
    #     ...
    #   >
    # ]

    ### CUSTOM READ ACTION - get by id ###
    assert %{title: "hello world"} =
             MyAshPhoenixApp.Blog.Post
             |> Ash.Query.for_read(:by_id, %{id: first_post.id})
             |> MyAshPhoenixApp.Blog.read_one!()

    ### UPDATE ACTION - update existing blog post ###
    # notice how you have to parse in an existing resource to the changeset
    assert %{
             title: "hello world",
             content: "hello to you too!"
           } =
             Ash.Changeset.for_update(first_post, :update, %{content: "hello to you too!"})
             |> MyAshPhoenixApp.Blog.update!()

    # will return:
    #
    # #MyAshPhoenixApp.Blog.Post<
    #   __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
    #   id: "d70dd979-0b30-4a3f-beb2-2d5bb2e24af7",
    #   title: "hello world",
    #   content: "hello to you too!",
    #   aggregates: %{},
    #   calculations: %{},
    #   __order__: nil,
    #   ...
    # >

    ### DELETE ACTION - delete existing blog post ###
    assert :ok ==
             Ash.Changeset.for_destroy(first_post, :destroy)
             |> MyAshPhoenixApp.Blog.destroy!()

    # verifying no rows in resource
    assert [] == MyAshPhoenixApp.Blog.read!(MyAshPhoenixApp.Blog.Post)
  end
end
