# MyAshPhoenixApp

This repo is the result of following the steps at found at https://hexdocs.pm/ash_phoenix/getting-started-with-ash-and-phoenix.html.

The tutorial gives instructions on 
  - how to setup your project
  - creating resources (including how to create and migrate the database)
  - interacting with your resources
  - connecting your resource to a Phoenix LiveView

When generating the project during the initial setup one can go to https://ash-hq.org rather than doing it manually. For the purposes of recreating the tutorial it suffices to pick the following installer options:

  * Presets -> Phoenix LiveView
  * Web -> Phoenix
  * Data Layers -> PostgreSQL

leaving the other fields unchecked.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
