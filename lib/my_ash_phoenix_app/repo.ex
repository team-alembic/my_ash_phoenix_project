defmodule MyAshPhoenixApp.Repo do
  use AshPostgres.Repo, otp_app: :my_ash_phoenix_app

  def installed_extensions do
    ["uuid-ossp", "citext"]
  end
end
