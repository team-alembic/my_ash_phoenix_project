defmodule MyAshPhoenixApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MyAshPhoenixAppWeb.Telemetry,
      MyAshPhoenixApp.Repo,
      {DNSCluster, query: Application.get_env(:my_ash_phoenix_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyAshPhoenixApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyAshPhoenixApp.Finch},
      # Start a worker by calling: MyAshPhoenixApp.Worker.start_link(arg)
      # {MyAshPhoenixApp.Worker, arg},
      # Start to serve requests, typically the last entry
      MyAshPhoenixAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyAshPhoenixApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyAshPhoenixAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
