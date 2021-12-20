defmodule Wallst.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    # example getting vars from environment
    name = System.get_env("NAME")

    # example getting vars from application
    author = Application.fetch_env!(:wallst, :author)

    Logger.info("#{name} developed by #{author}")

    children = [
      # Starts a worker by calling: Wallst.Worker.start_link(arg)
      {Wallst.Api.StockServer, []},
      {Plug.Cowboy, scheme: :http, plug: Wallst.Router, options: [port: cowboy_port()]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wallst.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:example, :cowboy_port, 8080)
end
