defmodule MyAshPhoenixApp.Repo do
  use Ecto.Repo,
    otp_app: :my_ash_phoenix_app,
    adapter: Ecto.Adapters.Postgres
end
