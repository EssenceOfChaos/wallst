defmodule Wallst.Router do
  @moduledoc """
  The Wallst.Router module directs incoming requests to their targets using pipelines.
  """
  alias Wallst.Api.StockServer
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/healthcheck" do
    IO.inspect(conn)
    send_resp(conn, 200, "Success")
  end

  get "/api/:name" do
    IO.inspect(conn.params["name"])
    stock_name = conn.params["name"]
    res = StockServer.get_price(:iex_server, stock_name)
    send_resp(conn, 200, res)

    # response = MovieService.get_all_movies()
    # response |> handle_response(conn)
  end

  match _ do
    send_resp(conn, 404, "Not found!")
  end

  # defp handle_response(response, conn) do
  #   %{code: code, message: message} =
  #     case response do
  #       {:ok, message} -> %{code: 200, message: message}
  #       {:not_found, message} -> %{code: 404, message: message}
  #       {:malformed_data, message} -> %{code: 400, message: message}
  #       {:server_error, _} -> %{code: 500, message: "An error occurred internally"}
  #     end

  #   conn |> send_resp(code, message)
  # end

  # Plug error handler
  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
