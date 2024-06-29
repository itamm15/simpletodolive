defmodule Simpletodolive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SimpletodoliveWeb.Telemetry,
      Simpletodolive.Repo,
      {DNSCluster, query: Application.get_env(:simpletodolive, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Simpletodolive.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Simpletodolive.Finch},
      # Start a worker by calling: Simpletodolive.Worker.start_link(arg)
      # {Simpletodolive.Worker, arg},
      # Start to serve requests, typically the last entry
      SimpletodoliveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Simpletodolive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimpletodoliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
