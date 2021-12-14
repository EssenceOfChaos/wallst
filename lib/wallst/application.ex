defmodule Wallst.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    app = System.get_env("APP")

    if app == nil do
      Logger.info("Starting app...")
    else
      Logger.info("Starting #{app}...")
    end

    children = [
      # Starts a worker by calling: Wallst.Worker.start_link(arg)
      {Wallst.Api.StockServer, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wallst.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
